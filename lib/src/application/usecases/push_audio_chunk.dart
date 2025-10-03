import 'dart:typed_data';

import '../../domain/repositories/i_speech_streaming_repository.dart';
import 'usecase.dart';

class PushAudioChunkUseCase implements UseCase<void, PushAudioChunkParams> {
  final ISpeechStreamingRepository _repository;

  PushAudioChunkUseCase(this._repository);

  @override
  Future<void> call(PushAudioChunkParams params) {
    return _repository.pushAudioChunk(params.chunk, meta: params.meta);
  }
}

class PushAudioChunkParams {
  final Uint8List chunk;
  final Map<String, dynamic> meta;

  PushAudioChunkParams({required this.chunk, required this.meta});
}
