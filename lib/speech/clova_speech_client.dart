// lib/speech/clova_speech_client.dart
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart' as grpc;
import 'package:flutter_application_2/speech/grpc_channel_factory.dart';

import '../generated/nest.pbgrpc.dart';

class ClovaSpeechClient {
  ClovaSpeechClient({
    required this.apiKey,
    this.host = 'clovaspeech-gw.ncloud.com',
    this.port = 50051,
    Map<String, String>? extraHeaders,
  }) : extraHeaders = extraHeaders ?? const {};

  final String apiKey;
  final String host;
  final int port;
  final Map<String, String> extraHeaders;

  grpc.ClientChannel? _channel;
  NestServiceClient? _client;

  Future<void> open() async {
    if (_client != null) {
      return;
    }

    _channel = createClientChannel(host, port);
    _client = NestServiceClient(_channel!);
  }

  Future<void> close() async {
    final channel = _channel;
    _client = null;
    _channel = null;
    if (channel != null) {
      await (channel as dynamic).shutdown();
    }
  }

  Future<ClovaStreamingSession> startStreaming({
    required Map<String, dynamic> config,
    CallOptions? callOptions,
  }) async {
    _ensureInitialized();

    final controller = StreamController<NestRequest>();
    final metadata = _buildMetadata();
    final options = callOptions == null
        ? CallOptions(metadata: metadata)
        : callOptions.mergedWith(CallOptions(metadata: metadata));

    final responses = _client!.recognize(controller.stream, options: options);

    controller.add(
      NestRequest()
        ..type = RequestType.CONFIG
        ..config = (NestConfig()..config = jsonEncode(config)),
    );

    return ClovaStreamingSession._(controller, responses);
  }

  /// CONFIG 호출만 테스트하려면 이 메서드를 사용하세요.
  Future<NestResponse?> pingConfig({Map<String, dynamic>? config}) async {
    _ensureInitialized();

    final session = await startStreaming(
      config:
          config ??
          const {
            'transcription': {'language': 'ko'},
          },
    );

    try {
      return await session.responses.first;
    } finally {
      await session.finish();
    }
  }

  void _ensureInitialized() {
    if (_client == null) {
      throw StateError(
        'Client is not opened. Call open() before using the API.',
      );
    }
  }

  Map<String, String> _buildMetadata() {
    if (apiKey.isEmpty) {
      throw StateError('Clova Speech API key must not be empty.');
    }
    final metadata = <String, String>{'authorization': 'Bearer $apiKey'};
    metadata.addAll(extraHeaders);
    return metadata;
  }
}

class ClovaStreamingSession {
  ClovaStreamingSession._(this._requestController, this.responses);

  final StreamController<NestRequest> _requestController;
  final ResponseStream<NestResponse> responses;

  bool _closed = false;

  void sendAudioChunk(Uint8List bytes, {Map<String, dynamic>? extra}) {
    if (_closed) return;
    _requestController.add(
      NestRequest()
        ..type = RequestType.DATA
        ..data = (NestData()
          ..chunk = bytes
          ..extraContents = extra == null ? '' : jsonEncode(extra)),
    );
  }

  Future<void> finish() async {
    if (_closed) return;
    _closed = true;
    await _requestController.close();
  }

  Future<void> cancel() async {
    await finish();
  }
}
