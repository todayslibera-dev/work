import 'package:flutter_application_2/src/domain/entities/speech_session_summary.dart';
import 'package:flutter_application_2/src/domain/entities/transcript_segment.dart';
import 'package:flutter_application_2/src/domain/repositories/i_document_repository.dart';
import '../datasources/i_local_file_datasource.dart';

class DocumentRepository implements IDocumentRepository {
  final ILocalFileDataSource _localFileDataSource;

  DocumentRepository(this._localFileDataSource);

  @override
  Future<SpeechSessionSummary> saveTranscript({
    required List<TranscriptSegment> segments,
    required String recordedAudioPath,
  }) async {
    final transcriptPath = await _localFileDataSource.saveTranscriptFile(
      segments: segments,
      audioFileName: recordedAudioPath,
    );

    return SpeechSessionSummary(
      audioPath: recordedAudioPath,
      transcriptPath: transcriptPath,
    );
  }
}
