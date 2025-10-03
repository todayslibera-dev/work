import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:grpc/grpc.dart';
import 'package:grpc/service_api.dart' as service_api;
import 'package:flutter_application_2/generated/nest.pbgrpc.dart';
import 'package:flutter_application_2/src/domain/entities/transcription_piece.dart';
import 'package:flutter_application_2/src/shared/logger.dart';
import 'package:flutter_application_2/speech/grpc_channel_factory.dart';
import 'i_clova_api_datasource.dart';

class ClovaApiDataSource implements IClovaApiDataSource {
  ClovaApiDataSource({
    required this.apiKey,
    this.host = 'clovaspeech-gw.ncloud.com',
    this.port = 50051,
  });

  final String apiKey;
  final String host;
  final int port;

  service_api.ClientChannel? _channel;
  NestServiceClient? _client;
  StreamController<NestRequest>? _requestController;
  ResponseStream<NestResponse>? _responseStream;

  @override
  Future<void> startStreaming({required Map<String, dynamic> config}) async {
    _channel = createClientChannel(host, port);
    _client = NestServiceClient(_channel!);

    _requestController = StreamController<NestRequest>();
    final metadata = {'authorization': 'Bearer $apiKey'};

    _responseStream = _client!.recognize(
      _requestController!.stream,
      options: CallOptions(metadata: metadata),
    );

    _requestController!.add(
      NestRequest()
        ..type = RequestType.CONFIG
        ..config = (NestConfig()..config = jsonEncode(config)),
    );
  }

  @override
  Stream<TranscriptionPiece> getTranscriptionStream() {
    if (_responseStream == null) {
      throw StateError('Stream not started. Call startStreaming first.');
    }
    return _responseStream!.map((response) {
      try {
        final decoded = jsonDecode(response.contents);

        if (decoded.containsKey('transcription')) {
          final transcription = decoded['transcription'];
          final startTimestamp = transcription['startTimestamp'];

          return TranscriptionPiece(
            text: transcription['text'] ?? '',
            isFinal: transcription['epFlag'] == true,
            position: transcription['position'],
            timestamp: startTimestamp != null ? Duration(milliseconds: startTimestamp) : null,
          );
        }

        if (decoded['event'] == 'ERROR') {
          throw Exception('Clova API Error: ${decoded['params']?['message']}');
        }

        return null; // Ignore other message types like config responses
      } catch (e) {
        logger.e('Error processing Clova response: $e');
        return null; // Ignore malformed messages to keep the stream alive
      }
    }).where((piece) => piece != null).cast<TranscriptionPiece>();
  }

  @override
  Future<void> pushAudioChunk(
      Uint8List chunk, {required Map<String, dynamic> meta}) async {
    if (_requestController == null || _requestController!.isClosed) {
      throw StateError('Stream not started or is closed.');
    }
    _requestController!.add(
      NestRequest()
        ..type = RequestType.DATA
        ..data = (NestData()
          ..chunk = chunk
          ..extraContents = jsonEncode(meta)),
    );
  }

  @override
  Future<void> completeSession() async {
    if (_requestController != null && !_requestController!.isClosed) {
      await _requestController!.close();
    }
    await (_channel as dynamic)?.shutdown();
  }

  @override
  Future<void> cancelSession() async {
    await completeSession();
  }
}

