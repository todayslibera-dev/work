import '../../domain/entities/transcript_segment.dart';

abstract class ILocalFileDataSource {
  Future<String> saveTranscriptFile({
    required List<TranscriptSegment> segments,
    required String audioFileName,
  });

  Future<String> get audoFilePath;
}
