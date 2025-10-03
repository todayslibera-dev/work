import '../../domain/repositories/speech_streaming_repository.dart';

/// Pushes a raw audio chunk into the current streaming session.
class PushAudioChunkUseCase {
  PushAudioChunkUseCase(this._repo);

  final SpeechStreamingRepository _repo;

  Future<void> call(List<int> bytes, {Map<String, dynamic>? meta}) async {
    await _repo.pushAudioChunk(bytes, meta: meta);
  }
}

