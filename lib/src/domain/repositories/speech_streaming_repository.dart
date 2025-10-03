import '../entities/transcription_piece.dart';

/// Abstraction for realtime speech streaming.
/// Infrastructure (gRPC, platform recorders, etc.) will implement this.
abstract class SpeechStreamingRepository {
  /// Open any underlying channels/resources if needed.
  Future<void> open();

  /// Start a new streaming session with a provider-specific config map.
  Future<void> start({required Map<String, dynamic> config});

  /// Push a raw audio chunk (e.g., PCM16) to the stream.
  Future<void> pushAudioChunk(List<int> bytes, {Map<String, dynamic>? meta});

  /// Signal end-of-input and complete the stream.
  Future<void> complete();

  /// Cancel the current session and discard intermediate state.
  Future<void> cancel();

  /// Close/free any resources.
  Future<void> close();

  /// Stream of transcription events (partial/final pieces).
  Stream<TranscriptionPiece> transcriptionStream();
}

