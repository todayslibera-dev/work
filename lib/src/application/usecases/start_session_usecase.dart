import '../../domain/repositories/speech_streaming_repository.dart';

/// Starts a new speech streaming session with the given provider config.
class StartSessionUseCase {
  StartSessionUseCase(this._repo);

  final SpeechStreamingRepository _repo;

  Future<void> call({required Map<String, dynamic> config}) async {
    await _repo.open();
    await _repo.start(config: config);
  }
}

