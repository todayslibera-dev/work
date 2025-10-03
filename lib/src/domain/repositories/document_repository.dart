import '../entities/speech_session_summary.dart';
import '../entities/transcript_segment.dart';

/// Abstraction for persisting transcript artifacts (HTML, files, web URLs...).
abstract class DocumentRepository {
  /// Persist transcript + audio reference on IO platforms and return summary.
  Future<SpeechSessionSummary> saveTranscript({
    required List<TranscriptSegment> segments,
    required String recordedAudioPath,
  });
}

