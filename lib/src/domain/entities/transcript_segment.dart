import 'package:freezed_annotation/freezed_annotation.dart';

part 'transcript_segment.freezed.dart';
part 'transcript_segment.g.dart';

@freezed
class TranscriptSegment with _$TranscriptSegment {
  const factory TranscriptSegment({
    required String id,
    required String text,
    required Duration timestamp,
  }) = _TranscriptSegment;

  factory TranscriptSegment.fromJson(Map<String, dynamic> json) =>
      _$TranscriptSegmentFromJson(json);
}