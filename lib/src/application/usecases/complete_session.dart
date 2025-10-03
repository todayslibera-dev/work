import '../../domain/repositories/i_speech_streaming_repository.dart';
import 'usecase.dart';

class CompleteSessionUseCase implements UseCase<void, NoParams> {
  final ISpeechStreamingRepository _repository;

  CompleteSessionUseCase(this._repository);

  @override
  Future<void> call(NoParams params) {
    return _repository.completeSession();
  }
}
