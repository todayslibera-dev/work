import '../../domain/repositories/i_speech_streaming_repository.dart';
import 'usecase.dart';

class StartSessionUseCase implements UseCase<void, StartSessionParams> {
  final ISpeechStreamingRepository _repository;

  StartSessionUseCase(this._repository);

  @override
  Future<void> call(StartSessionParams params) {
    return _repository.startStreaming(config: params.config);
  }
}

class StartSessionParams {
  final Map<String, dynamic> config;

  StartSessionParams({required this.config});
}
