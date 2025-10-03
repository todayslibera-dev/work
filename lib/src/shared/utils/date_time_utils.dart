import 'package:intl/intl.dart';

String formatDuration(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);

  String twoDigits(int value) => value.toString().padLeft(2, '0');

  if (hours > 0) {
    return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
  }
  return '${twoDigits(minutes)}:${twoDigits(seconds)}';
}

final NumberFormat _twoDigitsFormatter = NumberFormat('00');

String formatDurationWithTwoDigits(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);
  final minuteStr = _twoDigitsFormatter.format(minutes);
  final secondStr = _twoDigitsFormatter.format(seconds);
  if (hours > 0) {
    final hourStr = _twoDigitsFormatter.format(hours);
    return '$hourStr:$minuteStr:$secondStr';
  }
  return '$minuteStr:$secondStr';
}

String formatDurationForCheck(Duration duration) {
  final minutes = duration.inMinutes.remainder(60);
  final seconds = duration.inSeconds.remainder(60);
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  return '${twoDigits(minutes)}m${twoDigits(seconds)}s';
}