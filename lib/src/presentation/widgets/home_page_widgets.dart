import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/src/infrastructure/services/download_service.dart';
import 'package:flutter_application_2/src/presentation/state/controllers/speech_session_controller.dart';

class StatusRow extends StatelessWidget {
  const StatusRow({super.key, required this.controller});

  final SpeechSessionController controller;

  @override
  Widget build(BuildContext context) {
    final statusText = controller.state.displayName;

    final statusColor = switch (controller.state) {
      SessionState.idle => Colors.grey,
      SessionState.recording => Colors.red,
      SessionState.finalizing => Colors.deepPurple,
    };

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(statusText, style: Theme.of(context).textTheme.titleMedium),
        const Spacer(),
        Text('${controller.segments.length}개의 발화'),
      ],
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({super.key, required this.controller});

  final SpeechSessionController controller;

  @override
  Widget build(BuildContext context) {
    final hasTranscribableText =
        controller.segments.isNotEmpty ||
        controller.pendingPartial.trim().isNotEmpty;

    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: controller.isRecording
                ? null
                : () => controller.startSession(),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('시작'),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton.tonal(
            onPressed: controller.isRecording && hasTranscribableText
                ? controller.markCurrentSegment
                : null,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('체크'),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: FilledButton(
            onPressed: controller.isRecording
                ? () => controller.stopSession()
                : null,
            style: FilledButton.styleFrom(backgroundColor: Colors.black87),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text('종료'),
            ),
          ),
        ),
      ],
    );
  }
}

class LastSummarySection extends StatelessWidget {
  const LastSummarySection({super.key, required this.controller});

  final SpeechSessionController controller;

  @override
  Widget build(BuildContext context) {
    final summary = controller.lastSummary;
    if (summary == null) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 0,
      color: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '최근 세션 결과',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (!kIsWeb && summary.audioPath != null)
              SelectableText('오디오 파일: ${summary.audioPath}')
            else if (kIsWeb && summary.webAudioUrl != null)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => DownloadHelper.trigger(
                    summary.webAudioUrl!.toString(),
                    fileName: 'recording.webm',
                  ),
                  icon: const Icon(Icons.download),
                  label: const Text('오디오 다운로드'),
                ),
              ),
            const SizedBox(height: 4),
            if (!kIsWeb && summary.transcriptPath != null)
              SelectableText('문서 파일: ${summary.transcriptPath}')
            else if (kIsWeb && summary.webTranscriptUrl != null)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => DownloadHelper.trigger(
                    summary.webTranscriptUrl!.toString(),
                    fileName: 'transcript.html',
                  ),
                  icon: const Icon(Icons.description_outlined),
                  label: const Text('대화 문서 다운로드'),
                ),
              ),
            if (kIsWeb)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  '브라우저에서는 다운로드된 파일을 직접 저장해야 합니다.',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
          ],
        ),
      ),
    );
  }
}