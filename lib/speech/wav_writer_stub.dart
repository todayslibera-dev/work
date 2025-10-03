import 'dart:typed_data';

abstract class WavWriter {
  Future<void> write(Uint8List data);
  Future<void> close();
}

class _NoopWavWriter implements WavWriter {
  @override
  Future<void> write(Uint8List data) async {}

  @override
  Future<void> close() async {}
}

WavWriter createWavWriter(
  String path, {
  required int sampleRate,
  required int numChannels,
}) {
  return _NoopWavWriter();
}
