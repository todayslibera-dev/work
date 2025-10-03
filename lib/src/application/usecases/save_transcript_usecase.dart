import '../../domain/entities/speech_session_summary.dart';
import '../../domain/entities/transcript_segment.dart';
import '../../domain/repositories/document_repository.dart';

/// Persists transcript artifacts (document + audio reference) and returns a summary.
class SaveTranscriptUseCase {
  SaveTranscriptUseCase(this._docRepo);

  final DocumentRepository _docRepo;

  Future<SpeechSessionSummary> call({
    required List<TranscriptSegment> segments,
    required String recordedAudioPath,
  }) async {
    return _docRepo.saveTranscript(
      segments: segments,
      recordedAudioPath: recordedAudioPath,
    );
  }
}

