import '../../domain/repositories/speech_streaming_repository.dart';

/// Cancels the current streaming session and discards state.
class CancelSessionUseCase {
  CancelSessionUseCase(this._repo);

  final SpeechStreamingRepository _repo;

  Future<void> call() async {
    await _repo.cancel();
  }
}

