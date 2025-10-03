// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transcript_segment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TranscriptSegmentImpl _$$TranscriptSegmentImplFromJson(
  Map<String, dynamic> json,
) => _$TranscriptSegmentImpl(
  id: json['id'] as String,
  text: json['text'] as String,
  timestamp: Duration(microseconds: (json['timestamp'] as num).toInt()),
);

Map<String, dynamic> _$$TranscriptSegmentImplToJson(
  _$TranscriptSegmentImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'timestamp': instance.timestamp.inMicroseconds,
};
