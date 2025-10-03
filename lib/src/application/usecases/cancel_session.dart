import '../../domain/repositories/i_speech_streaming_repository.dart';
import 'usecase.dart';

class CancelSessionUseCase implements UseCase<void, NoParams> {
  final ISpeechStreamingRepository _repository;

  CancelSessionUseCase(this._repository);

  @override
  Future<void> call(NoParams params) {
    return _repository.cancelSession();
  }
}
