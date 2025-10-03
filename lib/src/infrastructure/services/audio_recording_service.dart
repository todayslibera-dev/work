import 'dart:async';
import 'dart:typed_data';

import 'package:record/record.dart';
import 'package:flutter_application_2/speech/wav_writer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_application_2/src/domain/services/i_audio_recording_service.dart';
import 'package:flutter_application_2/src/shared/logger.dart';

class AudioRecordingService implements IAudioRecordingService {
  final AudioRecorder _recorder;
  WavWriter? _wavWriter;
  StreamSubscription<Uint8List>? _audioSubscription;
  String? _recordedFilePath;

  final _audioChunkController = StreamController<Uint8List>.broadcast();

  AudioRecordingService({AudioRecorder? recorder})
      : _recorder = recorder ?? AudioRecorder();

  @override
  Stream<Uint8List> get audioChunkStream => _audioChunkController.stream;

  @override
  String? get recordedFilePath => _recordedFilePath;

  @override
  Future<void> startRecording({
    required int sampleRate,
    required int numChannels,
  }) async {
    final tempDir = await getTemporaryDirectory();
    _recordedFilePath = path.join(
      tempDir.path,
      'recording-${DateTime.now().millisecondsSinceEpoch}.wav',
    );
    final recordConfig = RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: sampleRate,
      numChannels: numChannels,
    );

    try {
      final hasMicPermission = await _recorder.hasPermission();
      if (!hasMicPermission) {
        logger.e('Microphone permission denied.');
        throw Exception('마이크 권한이 필요합니다. 시스템 설정에서 권한을 허용해 주세요.');
      }

      _wavWriter = createWavWriter(
        _recordedFilePath!,
        sampleRate: sampleRate,
        numChannels: numChannels,
      );

      final audioStream = await _recorder.startStream(recordConfig);
      _audioSubscription = audioStream.listen(
        (chunk) {
          _wavWriter?.write(chunk);
          _audioChunkController.add(chunk);
        },
        onError: (error) {
          logger.e('Error in audio stream', error: error);
          _audioChunkController.addError(error);
        },
        onDone: () {
          logger.i('Audio stream done.');
        },
      );
      logger.i('Recording started to $_recordedFilePath');
    } catch (e) {
      logger.e('Failed to start recording', error: e);
      rethrow;
    }
  }

  @override
  Future<void> stopRecording() async {
    await _audioSubscription?.cancel();
    _audioSubscription = null;
    await _recorder.stop();
    await _wavWriter?.close();
    _wavWriter = null;
    logger.i('Recording stopped.');
  }

  @override
  Future<void> cancelRecording() async {
    await _audioSubscription?.cancel();
    _audioSubscription = null;
    await _recorder.cancel();
    await _wavWriter?.close();
    _wavWriter = null;
    _recordedFilePath = null;
    logger.i('Recording cancelled.');
  }

  @override
  void dispose() {
    _audioSubscription?.cancel();
    _recorder.dispose();
    _audioChunkController.close();
    logger.i('AudioRecordingService disposed.');
  }
}
