// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speech_session_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpeechSessionSummaryImpl _$$SpeechSessionSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$SpeechSessionSummaryImpl(
  audioPath: json['audioPath'] as String?,
  transcriptPath: json['transcriptPath'] as String?,
  webAudioUrl: json['webAudioUrl'] == null
      ? null
      : Uri.parse(json['webAudioUrl'] as String),
  webTranscriptUrl: json['webTranscriptUrl'] == null
      ? null
      : Uri.parse(json['webTranscriptUrl'] as String),
);

Map<String, dynamic> _$$SpeechSessionSummaryImplToJson(
  _$SpeechSessionSummaryImpl instance,
) => <String, dynamic>{
  'audioPath': instance.audioPath,
  'transcriptPath': instance.transcriptPath,
  'webAudioUrl': instance.webAudioUrl?.toString(),
  'webTranscriptUrl': instance.webTranscriptUrl?.toString(),
};
