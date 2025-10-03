import '../../domain/entities/transcription_piece.dart';
import '../../domain/repositories/i_speech_streaming_repository.dart';
import 'usecase.dart';

class GetTranscriptionStreamUseCase
    implements StreamUseCase<TranscriptionPiece, NoParams> {
  final ISpeechStreamingRepository _repository;

  GetTranscriptionStreamUseCase(this._repository);

  @override
  Stream<TranscriptionPiece> call(NoParams params) {
    return _repository.getTranscriptionStream();
  }
}
