import '../../domain/repositories/speech_streaming_repository.dart';

/// Completes the streaming session (end-of-input) and awaits finalization.
class CompleteSessionUseCase {
  CompleteSessionUseCase(this._repo);

  final SpeechStreamingRepository _repo;

  Future<void> call() async {
    await _repo.complete();
  }
}

