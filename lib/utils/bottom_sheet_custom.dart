import 'package:flutter/material.dart';
import 'package:master_focus_todo/constants/images_path.dart';

/// Retorna um BottomSheet customizado
Future<T?> getBottomSheet<T>(
  BuildContext context,
  Widget child, {
  double minHeight = 0.3,
  double maxHeight = 0.9,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return Stack(clipBehavior: Clip.none, children: [
        Positioned(
          top: -36,
          left: MediaQuery.of(context).size.width / 2 - 32,
          child: Image.asset(
            splashIcon,
            width: 64,
            height: 64,
          ),
        ),
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * maxHeight,
            minHeight: MediaQuery.of(context).size.height * minHeight,
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: child,
        ),
      ]);
    },
  );
}
