import 'dart:async';
import 'dart:typed_data';

import '../../domain/entities/transcription_piece.dart';

abstract class IClovaApiDataSource {
  Future<void> startStreaming({required Map<String, dynamic> config});

  Stream<TranscriptionPiece> getTranscriptionStream();

  Future<void> pushAudioChunk(Uint8List chunk, {required Map<String, dynamic> meta});

  Future<void> completeSession();

  Future<void> cancelSession();
}
