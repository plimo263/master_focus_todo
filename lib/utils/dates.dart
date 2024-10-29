import 'package:intl/intl.dart';

String formatDate(DateTime date,
    [format = 'dd/MM/yyyy', bool byExtense = false]) {
  if (byExtense) {
    final inFormat = DateFormat('yyyy-MM-dd 00:00:00');
    final now = DateTime.parse(inFormat.format(DateTime.now()));
    final dateSend = DateTime.parse(inFormat.format(date));

    final difference = now.difference(dateSend).inDays;
    if (difference == 0) {
      return 'Hoje';
    } else if (difference == 1) {
      return 'Ontem';
    }
  }
  return DateFormat(format).format(date);
}

String formatSeconds(int seconds) {
  final minutes = (seconds / 60).floor();
  final remainingSeconds = seconds % 60;
  return '${minutes.toString().padLeft(2, '0')}'
      ':${remainingSeconds.toString().padLeft(2, '0')}';
}
