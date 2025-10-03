import '../../../speech/document_generator.dart';
import '../../domain/entities/speech_session_summary.dart';
import '../../domain/entities/transcript_segment.dart';
import '../../domain/repositories/document_repository.dart';

/// Adapter that forwards to existing DocumentGenerator for IO platforms.
class DocumentRepositoryImpl implements DocumentRepository {
  const DocumentRepositoryImpl();

  @override
  Future<SpeechSessionSummary> saveTranscript({
    required List<TranscriptSegment> segments,
    required String recordedAudioPath,
  }) async {
    return DocumentGenerator.createTranscriptDocument(
      segments: segments,
      recordedAudioPath: recordedAudioPath,
    );
  }
}

