import '../../domain/entities/speech_session_summary.dart';
import '../../domain/entities/transcript_segment.dart';
import '../../domain/repositories/i_document_repository.dart';
import 'usecase.dart';

class SaveTranscriptUseCase
    implements UseCase<SpeechSessionSummary, SaveTranscriptParams> {
  final IDocumentRepository _repository;

  SaveTranscriptUseCase(this._repository);

  @override
  Future<SpeechSessionSummary> call(SaveTranscriptParams params) {
    return _repository.saveTranscript(
      segments: params.segments,
      recordedAudioPath: params.recordedAudioPath,
    );
  }
}

class SaveTranscriptParams {
  final List<TranscriptSegment> segments;
  final String recordedAudioPath;

  SaveTranscriptParams({
    required this.segments,
    required this.recordedAudioPath,
  });
}
