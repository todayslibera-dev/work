import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_application_2/src/domain/entities/transcription_piece.dart';
import 'package:flutter_application_2/src/domain/repositories/i_speech_streaming_repository.dart';
import '../datasources/i_clova_api_datasource.dart';

class SpeechStreamingRepository implements ISpeechStreamingRepository {
  final IClovaApiDataSource _clovaApiDataSource;

  SpeechStreamingRepository(this._clovaApiDataSource);

  @override
  Future<void> startStreaming({required Map<String, dynamic> config}) {
    return _clovaApiDataSource.startStreaming(config: config);
  }

  @override
  Stream<TranscriptionPiece> getTranscriptionStream() {
    return _clovaApiDataSource.getTranscriptionStream();
  }

  @override
  Future<void> pushAudioChunk(
      Uint8List chunk, {required Map<String, dynamic> meta}) {
    return _clovaApiDataSource.pushAudioChunk(chunk, meta: meta);
  }

  @override
  Future<void> completeSession() {
    return _clovaApiDataSource.completeSession();
  }

  @override
  Future<void> cancelSession() {
    return _clovaApiDataSource.cancelSession();
  }
}
