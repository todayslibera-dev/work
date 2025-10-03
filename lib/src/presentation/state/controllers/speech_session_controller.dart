import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:record/record.dart';

import 'package:flutter_application_2/src/application/usecases/cancel_session.dart';
import 'package:flutter_application_2/src/application/usecases/complete_session.dart';
import 'package:flutter_application_2/src/application/usecases/get_transcription_stream.dart';
import 'package:flutter_application_2/src/application/usecases/push_audio_chunk.dart';
import 'package:flutter_application_2/src/application/usecases/save_transcript.dart';
import 'package:flutter_application_2/src/application/usecases/start_session.dart';
import 'package:flutter_application_2/src/application/usecases/usecase.dart';
import 'package:flutter_application_2/src/domain/entities/speech_session_summary.dart';
import 'package:flutter_application_2/src/domain/entities/transcript_segment.dart';
import 'package:flutter_application_2/src/domain/entities/transcription_piece.dart';
import 'package:flutter_application_2/src/shared/app_strings.dart';
import 'package:flutter_application_2/src/shared/logger.dart';
import 'package:flutter_application_2/src/domain/services/i_audio_recording_service.dart';
import 'package:flutter_application_2/src/shared/utils/date_time_utils.dart';

enum SessionState { idle, recording, finalizing }

class SpeechSessionController extends ChangeNotifier {
  SpeechSessionController({
    required this.apiKey,
    required this.startSessionUseCase,
    required this.getTranscriptionStreamUseCase,
    required this.pushAudioChunkUseCase,
    required this.completeSessionUseCase,
    required this.cancelSessionUseCase,
    required this.saveTranscriptUseCase,
    required this.audioRecordingService, // Modified
  });

  final String apiKey;
  final StartSessionUseCase startSessionUseCase;
  final GetTranscriptionStreamUseCase getTranscriptionStreamUseCase;
  final PushAudioChunkUseCase pushAudioChunkUseCase;
  final CompleteSessionUseCase completeSessionUseCase;
  final CancelSessionUseCase cancelSessionUseCase;
  final SaveTranscriptUseCase saveTranscriptUseCase;
  final IAudioRecordingService audioRecordingService; // Modified

  static const int _sampleRate = 16000; // Keep sample rate for config
  static const RecordConfig _recordConfig = RecordConfig( // Keep record config for numChannels
    encoder: AudioEncoder.pcm16bits,
    sampleRate: _sampleRate,
    numChannels: 1,
  );

  final List<TranscriptSegment> _segments = [];
  final SplayTreeMap<int, _ClovaChunk> _pendingChunks = SplayTreeMap();
  String _pendingPartial = '';
  Duration _pendingTimestamp = Duration.zero;
  DateTime? _sessionStart;
  SessionState _state = SessionState.idle;
  SpeechSessionSummary? _lastSummary;
  String? _errorMessage;
  int _segmentCounter = 0;
  int _nextSeqId = 0;

  StreamSubscription<TranscriptionPiece>? _clovaSubscription;
  StreamSubscription<Uint8List>? _audioChunkSubscription;

  SessionState get state => _state;
  bool get isRecording => _state == SessionState.recording;
  List<TranscriptSegment> get segments => List.unmodifiable(_segments);
  String get liveTranscript => _buildLiveTranscript();
  SpeechSessionSummary? get lastSummary => _lastSummary;
  String? get errorMessage => _errorMessage;
  String get pendingPartial => _pendingPartial;
  Duration get pendingTimestamp => _pendingTimestamp;

  Future<void> startSession() async {
    if (_state == SessionState.recording) {
      return;
    }

    _errorMessage = null;
    // Microphone permission check and recording path generation moved to AudioRecordingService

    _segments.clear();
    _pendingChunks.clear();
    _pendingPartial = '';
    _pendingTimestamp = Duration.zero;
    _sessionStart = DateTime.now();
    _state = SessionState.recording;

    _nextSeqId = 0;

    try {
      await startSessionUseCase(StartSessionParams(config: _buildStreamingConfig()));

      _clovaSubscription = getTranscriptionStreamUseCase(NoParams()).listen(
        _handleTranscriptionPiece,
        onError: (error) {
          final msg = _standardizeError(error);
          _setError(msg);
          notifyListeners();
        },
      );
    } catch (error) {
      _setError('${AppStrings.clovaStreamingFailed}$error');
      _state = SessionState.idle;
      notifyListeners();
      return;
    }

    try {
      await audioRecordingService.startRecording(
        sampleRate: _sampleRate,
        numChannels: _recordConfig.numChannels,
      );
      _audioChunkSubscription = audioRecordingService.audioChunkStream.listen(
        (chunk) {
          pushAudioChunkUseCase(PushAudioChunkParams(chunk: chunk, meta: {'seqId': _nextSeqId++, 'epFlag': false}));
        },
        onError: (error) {
          _setError('${AppStrings.audioStreamError}$error');
          notifyListeners();
        },
      );
    } catch (error) {
      _setError('${AppStrings.audioStreamError}$error');
      _state = SessionState.idle;
      notifyListeners();
      return;
    }

    notifyListeners();
  }

  Future<SpeechSessionSummary?> stopSession() async {
    if (_state != SessionState.recording) {
      return null;
    }

    _state = SessionState.finalizing;
    notifyListeners();

    await audioRecordingService.stopRecording(); // Modified
    await completeSessionUseCase(NoParams());
    await _clovaSubscription?.cancel();
    _clovaSubscription = null;
    await _audioChunkSubscription?.cancel();
    _audioChunkSubscription = null;

    _finalizePendingPartial();

    SpeechSessionSummary? summary;
    final recordedAudioPath = audioRecordingService.recordedFilePath; // Modified
    if (!kIsWeb && recordedAudioPath != null) { // Modified
      try {
        summary = await saveTranscriptUseCase(SaveTranscriptParams(
          segments: List.unmodifiable(_segments),
          recordedAudioPath: recordedAudioPath, // Modified
        ));
        _lastSummary = summary;
      } catch (error) {
        _setError('${AppStrings.documentCreationError}$error');
      }
    }

    _state = SessionState.idle;
    notifyListeners();
    return summary;
  }

  Future<void> cancelSession() async {
    if (_state == SessionState.idle) {
      return;
    }

    await audioRecordingService.cancelRecording(); // Modified
    await cancelSessionUseCase(NoParams());
    await _clovaSubscription?.cancel();
    _clovaSubscription = null;
    await _audioChunkSubscription?.cancel();
    _audioChunkSubscription = null;

    _pendingChunks.clear();

    _state = SessionState.idle;
    _segments.clear();
    _pendingPartial = '';
    _pendingTimestamp = Duration.zero;
    _sessionStart = null;
    // _recordingPath is managed by AudioRecordingService
    notifyListeners();
  }

  @override
  void dispose() {
    _clovaSubscription?.cancel();
    _audioChunkSubscription?.cancel();
    audioRecordingService.dispose(); // Modified
    super.dispose();
  }

  void markCurrentSegment() {
    if (_state != SessionState.recording) {
      return;
    }

    final timestamp = _elapsedSinceStart();
    final timestampStr = formatDurationForCheck(timestamp);
    final checkMarker = ' check: [$timestampStr]';

    final partial = _pendingPartial.trim();
    if (partial.isNotEmpty) {
      // Finalize the current pending text as a new segment
      _segments.add(
        TranscriptSegment(
          id: _nextSegmentId(),
          text: partial + checkMarker, // Add marker to the finalized text
          timestamp: _pendingTimestamp,
        ),
      );
      // Clear the pending state
      _pendingPartial = '';
      _pendingChunks.clear();
      notifyListeners();
      return;
    }

    // If there are segments, append the marker to the last segment's text.
    if (_segments.isNotEmpty) {
      final last = _segments.removeLast();
      _segments.add(last.copyWith(text: last.text + checkMarker));
      notifyListeners();
      return;
    }
  }

  void _handleTranscriptionPiece(TranscriptionPiece piece) {
    final text = piece.text.trim();
    if (text.isEmpty) return;

    final position = piece.position ?? _pendingChunks.length;

    if (piece.isFinal) {
      _pendingChunks[position] = _ClovaChunk(
        position: position,
        text: text,
        timestamp: piece.timestamp,
      );

      final consolidated = _collectPendingText();
      if (consolidated.isNotEmpty) {
        final firstTimestamp =
            _pendingChunks.values.first.timestamp ?? _elapsedSinceStart();
        _segments.add(
          TranscriptSegment(
            id: _nextSegmentId(),
            text: consolidated,
            timestamp: firstTimestamp,
          ),
        );
      }
      _pendingPartial = '';
      _pendingChunks.clear();
    } else {
      _pendingChunks[position] = _ClovaChunk(
        position: position,
        text: text,
        timestamp: piece.timestamp ?? _elapsedSinceStart(),
      );
      _pendingPartial = _collectPendingText();
      _pendingTimestamp =
          _pendingChunks.values.first.timestamp ?? _elapsedSinceStart();
    }

    notifyListeners();
  }

  String _buildLiveTranscript() => '';

  void _setError(String message) {
    _errorMessage = message;
    logger.e(message);
  }

  Map<String, dynamic> _buildStreamingConfig() => {
        'transcription': {'language': 'ko'}
      };

  String _standardizeError(Object error) {
    logger.e('Unhandled error in SpeechSessionController', error: error);
    return error.toString();
  }

  void _finalizePendingPartial() {
    final consolidated = _collectPendingText();
    if (consolidated.isNotEmpty) {
      final firstTimestamp =
          _pendingChunks.values.first.timestamp ?? _elapsedSinceStart();
      _segments.add(
        TranscriptSegment(
          id: _nextSegmentId(),
          text: consolidated,
          timestamp: firstTimestamp,
        ),
      );
    }
    _pendingPartial = '';
    _pendingChunks.clear();
  }

  String _nextSegmentId() => (_segmentCounter++).toString();

  String _collectPendingText() {
    return _pendingChunks.values.map((c) => c.text).join(' ');
  }

  Duration _elapsedSinceStart() {
    if (_sessionStart == null) return Duration.zero;
    return DateTime.now().difference(_sessionStart!); // Re-added '!'
  }
}

extension SessionStateExtension on SessionState {
  String get displayName {
    return switch (this) {
      SessionState.idle => '대기 중',
      SessionState.recording => '녹음 & 인식 중',
      SessionState.finalizing => '문서 작성 중',
    };
  }
}

class _ClovaChunk {
  _ClovaChunk({required this.position, required this.text, this.timestamp});

  final int position;
  final String text;
  final Duration? timestamp;
}
