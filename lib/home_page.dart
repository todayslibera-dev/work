import 'package:flutter/material.dart';
import 'package:flutter_application_2/clova_debug_page.dart';
import 'package:flutter_application_2/src/presentation/state/controllers/speech_session_controller.dart';

import 'src/shared/di/service_locator.dart';
import 'src/shared/utils/date_time_utils.dart'; // Added

import 'package:flutter_application_2/src/presentation/widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SpeechSessionController _controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = sl<SpeechSessionController>();
    // Pre-initialize gRPC channel so the first tap feels responsive.
    // _controller.initialize();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        _scrollToBottomOnNextFrame();
        return Scaffold(
          appBar: AppBar(
            title: const Text('실시간 음성 기록'),
            actions: [
              IconButton(
                tooltip: 'Clova gRPC 테스트',
                icon: const Icon(Icons.wifi_tethering),
                onPressed: () {
                  Navigator.of(context).pushNamed(ClovaDebugPage.routeName);
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StatusRow(controller: _controller),
                const SizedBox(height: 12),
                if (_controller.errorMessage != null)
                  _ErrorBanner(message: _controller.errorMessage!),
                Expanded(
                  child: _TranscriptListView(
                    controller: _controller,
                    scrollController: _scrollController,
                  ),
                ),
                const SizedBox(height: 16),
                LastSummarySection(controller: _controller),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Controls(controller: _controller),
          ),
        );
      },
    );
  }

  void _scrollToBottomOnNextFrame() {
    if (!_scrollController.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }
}

class _TranscriptListView extends StatelessWidget {
  const _TranscriptListView({
    required this.controller,
    required this.scrollController,
  });

  final SpeechSessionController controller;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final rows = <_TranscriptRow>[
      ...controller.segments.map(
        (segment) => _TranscriptRow(
          text: segment.text,
          timestamp: segment.timestamp,
          isPending: false,
        ),
      ),
    ];

    final partial = controller.pendingPartial.trim();
    if (partial.isNotEmpty) {
      rows.add(
        _TranscriptRow(
          text: partial,
          timestamp: controller.pendingTimestamp,
          isPending: true,
        ),
      );
    }

    if (rows.isEmpty) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('버튼을 눌러 녹음을 시작하면 실시간 텍스트가 표시됩니다.'),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => _TranscriptListTile(row: rows[index]),
        separatorBuilder: (context, _) => const SizedBox(height: 12),
        itemCount: rows.length,
      ),
    );
  }
}

class _TranscriptRow {
  _TranscriptRow({
    required this.text,
    required this.timestamp,
    required this.isPending,
  });

  final String text;
  final Duration timestamp;
  final bool isPending;
}

class _TranscriptListTile extends StatelessWidget {
  const _TranscriptListTile({required this.row});

  final _TranscriptRow row;

  @override
  Widget build(BuildContext context) {
    final timeLabel = formatDuration(row.timestamp);
    final baseStyle =
        Theme.of(context).textTheme.bodyLarge ??
        Theme.of(context).textTheme.bodyMedium ??
        const TextStyle();

    final textStyle = baseStyle.copyWith(
      fontStyle: row.isPending ? FontStyle.italic : FontStyle.normal,
      color: row.isPending ? Colors.blueGrey : baseStyle.color,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(
            timeLabel,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(row.text, style: textStyle)),
      ],
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}
