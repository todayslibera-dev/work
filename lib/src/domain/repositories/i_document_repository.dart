import '../entities/speech_session_summary.dart';
import '../entities/transcript_segment.dart';

abstract class IDocumentRepository {
  Future<SpeechSessionSummary> saveTranscript({
    required List<TranscriptSegment> segments,
    required String recordedAudioPath,
  });
}
