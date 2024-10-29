import 'package:flutter/material.dart';
import 'package:master_focus_todo/utils/contexts.dart';

SnackBar _getSnackBar(
  String message,
  Color color, [
  Duration duration = const Duration(seconds: 3),
]) {
  return SnackBar(
    duration: duration,
    elevation: 0,
    padding: EdgeInsets.zero,
    content: Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      constraints: const BoxConstraints(
        minHeight: 48,
        minWidth: double.infinity,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(message),
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}

void snackInfo(String message) {
  scaffoldMessenger.currentState!.showSnackBar(
    _getSnackBar(message, Colors.blue),
  );
}

void snackError(String message) {
  scaffoldMessenger.currentState!.showSnackBar(
    _getSnackBar(message, Colors.red),
  );
}

void snackSuccess(String message) {
  scaffoldMessenger.currentState!.showSnackBar(
    _getSnackBar(message, Colors.green),
  );
}

void snackWarning(String message) {
  scaffoldMessenger.currentState!.showSnackBar(
    _getSnackBar(message, Colors.orange),
  );
}
