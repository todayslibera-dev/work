import 'package:flutter/material.dart';

import 'speech/clova_speech_client.dart';

class ClovaDebugPage extends StatefulWidget {
  const ClovaDebugPage({super.key, required this.apiKey});

  static const routeName = '/clova-debug';

  final String apiKey;

  @override
  State<ClovaDebugPage> createState() => _ClovaDebugPageState();
}

class _ClovaDebugPageState extends State<ClovaDebugPage> {
  late final ClovaSpeechClient _client;
  String _log = '';
  bool _isBusy = false;

  @override
  void initState() {
    super.initState();
    _client = ClovaSpeechClient(apiKey: widget.apiKey);
    if (widget.apiKey.isEmpty) {
      _append('[WARN] CLOVA_API_KEY가 설정되지 않아 테스트를 수행할 수 없습니다.');
      return;
    }
    _sendConfig();
  }

  Future<void> _sendConfig() async {
    if (_isBusy) return;
    if (widget.apiKey.isEmpty) {
      _append(
        '[WARN] CLOVA_API_KEY가 비어 있습니다. --dart-define 또는 다른 방법으로 키를 주입하세요.',
      );
      return;
    }
    setState(() {
      _isBusy = true;
      _log = '';
    });

    try {
      await _client.open();
      _append('[CONFIG] sending...');
      final session = await _client.startStreaming(
        config: {
          'transcription': {
            'language': 'ko',
          },
        },
      );
      try {
        final first = await session.responses.first;
        _append('[CONFIG] ${first.contents}');
      } on StateError {
        _append('[WARN] 응답을 받지 못했습니다.');
      } finally {
        await session.finish();
      }
    } catch (error) {
      _append('[ERROR] $error');
    } finally {
      if (mounted) {
        setState(() {
          _isBusy = false;
        });
      }
    }
  }

  void _append(String value) {
    setState(() {
      _log = _log.isEmpty ? '$value\n' : '$_log$value\n';
    });
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clova gRPC Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton.icon(
              onPressed: _isBusy ? null : _sendConfig,
              icon: const Icon(Icons.play_arrow),
              label: const Text('CONFIG 호출'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SingleChildScrollView(
                    child: Text(
                      _log.isEmpty ? '로그가 없습니다.' : _log,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
