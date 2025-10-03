import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import '../../../speech/clova_speech_client.dart';
import '../../../generated/nest.pb.dart' as nest;
import '../../domain/entities/transcription_piece.dart';
import '../../domain/errors/failures.dart';
import 'package:grpc/grpc.dart' as grpc;
import '../../domain/repositories/speech_streaming_repository.dart';

/// Infrastructure adapter that wraps ClovaSpeechClient and exposes
/// the domain SpeechStreamingRepository interface.
class ClovaGrpcStreamingRepository implements SpeechStreamingRepository {
  ClovaGrpcStreamingRepository({
    required this.apiKey,
    ClovaSpeechClient? client,
  }) : _client = client ?? ClovaSpeechClient(apiKey: apiKey);

  final String apiKey;
  final ClovaSpeechClient _client;

  StreamController<TranscriptionPiece>? _pieces;
  ClovaStreamingSession? _session;
  StreamSubscription<nest.NestResponse>? _subscription;

  @override
  Future<void> open() async {
    await _client.open();
  }

  @override
  Future<void> start({required Map<String, dynamic> config}) async {
    // (Re)create controller per session
    await _subscription?.cancel();
    await _pieces?.close();
    _pieces = StreamController<TranscriptionPiece>.broadcast();

    _session = await _client.startStreaming(config: config);
    _subscription = _session!.responses.listen(
      (resp) {
        final piece = _mapResponse(resp);
        if (piece != null) {
          _pieces?.add(piece);
        }
      },
      onError: (e, st) => _pieces?.addError(_mapError(e), st),
      onDone: () => _pieces?.close(),
    );
  }

  @override
  Future<void> pushAudioChunk(
    List<int> bytes, {
    Map<String, dynamic>? meta,
  }) async {
    final s = _session;
    if (s == null) return;
    s.sendAudioChunk(Uint8List.fromList(bytes), extra: meta);
  }

  @override
  Future<void> complete() async => _session?.finish();

  @override
  Future<void> cancel() async => _session?.cancel();

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await _pieces?.close();
    await _client.close();
  }

  @override
  Stream<TranscriptionPiece> transcriptionStream() {
    final ctrl = _pieces;
    if (ctrl == null) {
      // Provide an empty stream before start() is called
      return const Stream<TranscriptionPiece>.empty();
    }
    return ctrl.stream;
  }

  TranscriptionPiece? _mapResponse(nest.NestResponse response) {
    final raw = response.contents;
    if (raw.trim().isEmpty) return null;
    dynamic decoded;
    try {
      decoded = jsonDecode(raw);
    } catch (_) {
      return TranscriptionPiece(text: raw, isFinal: true);
    }

    if (decoded is String) {
      return TranscriptionPiece(text: decoded, isFinal: true);
    }

    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    Map<String, dynamic>? asMap(dynamic v) {
      if (v is Map<String, dynamic>) return v;
      if (v is Map) {
        return v.map((k, dynamic val) => MapEntry(k.toString(), val));
      }
      return null;
    }

    Duration? parseTs(dynamic v) {
      if (v == null) return null;
      if (v is num) {
        if (v > 3600) return Duration(milliseconds: v.round());
        return Duration(milliseconds: (v * 1000).round());
      }
      if (v is String) {
        final t = v.trim();
        if (t.isEmpty) return null;
        final n = num.tryParse(t);
        if (n != null) return parseTs(n);
      }
      return null;
    }

    final transcription =
        asMap(decoded['transcription']) ??
        asMap(decoded['result']) ??
        asMap(asMap(decoded['message'])?['transcription']);
    if (transcription == null) return null;

    final text = transcription['text'] as String?;
    if (text == null) return null;

    final epFlag = transcription['epFlag'] == true;
    final responseTypes =
        (decoded['responseType'] as List?)
            ?.map((e) => e.toString().toLowerCase())
            .toSet() ??
        const {};
    final isFinal =
        epFlag ||
        responseTypes.contains('final') ||
        responseTypes.contains('finalresult');
    final ts =
        parseTs(transcription['endTimestamp']) ??
        parseTs(transcription['endTime']);
    final pos = (transcription['position'] as num?)?.toInt();

    return TranscriptionPiece(
      text: text,
      isFinal: isFinal,
      timestamp: ts,
      position: pos,
    );
  }

  StreamingFailure _mapError(Object error) {
    if (error is StreamingFailure) return error;
    if (error is grpc.GrpcError) {
      final code = error.codeName ?? error.code.toString();
      final errorMessage = error.message;
      final msg = (errorMessage == null || errorMessage.isEmpty) ? 'gRPC error' : errorMessage;
      return StreamingFailure(code: code, message: msg);
    }
    // Fallback
    return StreamingFailure(code: 'UNKNOWN', message: error.toString());
  }
}