import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

abstract class WavWriter {
  Future<void> write(Uint8List data);
  Future<void> close();
}

class _FileWavWriter implements WavWriter {
  _FileWavWriter(
    this._file, {
    required this.sampleRate,
    required this.numChannels,
  });

  final File _file;
  final int sampleRate;
  final int numChannels;

  late final RandomAccessFile _raf;
  int _dataLength = 0;
  bool _isOpen = false;

  Future<void> _ensureOpen() async {
    if (_isOpen) return;
    if (!await _file.parent.exists()) {
      await _file.parent.create(recursive: true);
    }
    _raf = await _file.open(mode: FileMode.write);
    _isOpen = true;
    await _raf.writeFrom(_emptyWavHeader);
  }

  @override
  Future<void> write(Uint8List data) async {
    await _ensureOpen();
    await _raf.writeFrom(data);
    _dataLength += data.length;
  }

  @override
  Future<void> close() async {
    if (!_isOpen) {
      return;
    }

    await _raf.flush();
    await _raf.setPosition(0);
    await _raf.writeFrom(_buildHeader());
    await _raf.close();
    _isOpen = false;
  }

  Uint8List _buildHeader() {
    final byteRate = sampleRate * numChannels * 2; // 16-bit PCM
    final blockAlign = numChannels * 2;
    final chunkSize = 36 + _dataLength;

    final buffer = BytesBuilder();
    buffer
      ..add(_ascii.encode('RIFF'))
      ..add(_int32ToBytes(chunkSize))
      ..add(_ascii.encode('WAVE'))
      ..add(_ascii.encode('fmt '))
      ..add(_int32ToBytes(16)) // Subchunk1Size for PCM
      ..add(_int16ToBytes(1)) // AudioFormat = PCM
      ..add(_int16ToBytes(numChannels))
      ..add(_int32ToBytes(sampleRate))
      ..add(_int32ToBytes(byteRate))
      ..add(_int16ToBytes(blockAlign))
      ..add(_int16ToBytes(16)) // BitsPerSample
      ..add(_ascii.encode('data'))
      ..add(_int32ToBytes(_dataLength));
    return buffer.toBytes();
  }
}

WavWriter createWavWriter(
  String path, {
  required int sampleRate,
  required int numChannels,
}) {
  final file = File(path);
  return _FileWavWriter(file, sampleRate: sampleRate, numChannels: numChannels);
}

Uint8List _int16ToBytes(int value) {
  final bytes = Uint8List(2);
  final bd = ByteData.sublistView(bytes);
  bd.setInt16(0, value, Endian.little);
  return bytes;
}

Uint8List _int32ToBytes(int value) {
  final bytes = Uint8List(4);
  final bd = ByteData.sublistView(bytes);
  bd.setInt32(0, value, Endian.little);
  return bytes;
}

const _ascii = AsciiCodec();

final _emptyWavHeader = Uint8List(44);
