class StreamingFailure implements Exception {
  StreamingFailure({required this.code, required this.message});

  final String code;
  final String message;

  @override
  String toString() => 'StreamingFailure($code): $message';
}

