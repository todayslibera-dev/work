import '../../domain/entities/transcription_piece.dart';
import '../../domain/repositories/speech_streaming_repository.dart';

/// Exposes the unified transcription stream from the repository.
class GetTranscriptionStreamUseCase {
  GetTranscriptionStreamUseCase(this._repo);

  final SpeechStreamingRepository _repo;

  Stream<TranscriptionPiece> call() => _repo.transcriptionStream();
}

