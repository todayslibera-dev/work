import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:flutter_application_2/src/shared/utils/date_time_utils.dart';

import 'session_models.dart';

class DocumentGenerator {
  DocumentGenerator._();

  static final DateFormat _timestampFormatter = DateFormat('yyyyMMdd_HHmmss');

  static Future<SpeechSessionSummary> createTranscriptDocument({
    required List<TranscriptSegment> segments,
    required String recordedAudioPath,
  }) async {
    final docsDir = await getApplicationDocumentsDirectory();
    final sessionId = _timestampFormatter.format(DateTime.now());
    final sessionDir = Directory(
      p.join(docsDir.path, 'speech_sessions', sessionId),
    );
    if (!await sessionDir.exists()) {
      await sessionDir.create(recursive: true);
    }

    final audioSource = File(recordedAudioPath);
    final savedAudio = File(
      p.join(sessionDir.path, p.basename(recordedAudioPath)),
    );
    await audioSource.copy(savedAudio.path);

    final transcriptFile = File(p.join(sessionDir.path, 'transcript.html'));
    final transcriptHtml = _buildHtml(segments, savedAudio.path);
    await transcriptFile.writeAsString(transcriptHtml, flush: true);

    return SpeechSessionSummary(
      audioPath: savedAudio.path,
      transcriptPath: transcriptFile.path,
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
