import 'dart:async';
import 'dart:typed_data';

abstract class IAudioRecordingService {
  Future<void> startRecording({required int sampleRate, required int numChannels});
  Future<void> stopRecording();
  Future<void> cancelRecording();
  Stream<Uint8List> get audioChunkStream;
  String? get recordedFilePath;
  void dispose();
}