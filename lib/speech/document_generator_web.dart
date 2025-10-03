// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;



import 'package:flutter_application_2/src/shared/utils/date_time_utils.dart';

import 'session_models.dart';

class DocumentGenerator {
  DocumentGenerator._();

  static Future<SpeechSessionSummary> createTranscriptDocument({
    required List<TranscriptSegment> segments,
    required String recordedAudioPath,
  }) async {
    final transcriptHtml = _buildHtml(segments, '오디오 파일은 별도로 저장되었습니다.');
    final transcriptBlob = html.Blob([transcriptHtml], 'text/html');
    final transcriptUrl = html.Url.createObjectUrl(transcriptBlob);

    return SpeechSessionSummary(
      webAudioUrl: Uri.parse(recordedAudioPath),
      webTranscriptUrl: Uri.parse(transcriptUrl),
    );
  }

  static String _buildHtml(List<TranscriptSegment> segments, String audioPath) {
    final buffer = StringBuffer();
    buffer
      ..writeln('<!DOCTYPE html>')
      ..writeln('<html lang="ko">')
      ..writeln('<head>')
      ..writeln('<meta charset="utf-8"/>')
      ..writeln('<title>Speech Session Transcript</title>')
      ..writeln(
        '<style>body{font-family:Arial,Helvetica,sans-serif;margin:24px;line-height:1.6;} '
        'h1{font-size:22px;} time{color:#555;margin-right:12px;} '
        'u{font-weight:600;}</style>',
      )
      ..writeln('</head>')
      ..writeln('<body>')
      ..writeln('<h1>대화 기록</h1>')
      ..writeln('<p><strong>저장된 오디오:</strong> $audioPath</p>')
      ..writeln('<hr/>');

    for (final segment in segments) {
      final trimmed = segment.text.trim();
      if (trimmed.isEmpty) continue;
      final safeText = _escapeHtml(trimmed);
      buffer.writeln(
        '<p><time>${formatDuration(segment.timestamp)}</time>$safeText</p>',
      );
    }

    buffer
      ..writeln('</body>')
      ..writeln('</html>');
    return buffer.toString();
  }

  static String _escapeHtml(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;');
  }
}
