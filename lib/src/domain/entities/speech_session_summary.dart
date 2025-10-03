import 'package:freezed_annotation/freezed_annotation.dart';

part 'speech_session_summary.freezed.dart';
part 'speech_session_summary.g.dart';

@freezed
class SpeechSessionSummary with _$SpeechSessionSummary {
  const factory SpeechSessionSummary({
    String? audioPath,
    String? transcriptPath,
    Uri? webAudioUrl,
    Uri? webTranscriptUrl,
  }) = _SpeechSessionSummary;

  factory SpeechSessionSummary.fromJson(Map<String, dynamic> json) =>
      _$SpeechSessionSummaryFromJson(json);
}