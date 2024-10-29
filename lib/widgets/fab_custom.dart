import 'package:flutter/material.dart';
import 'package:master_focus_todo/constants/images_path.dart';

class FabCustom extends StatelessWidget {
  final void Function()? onPressed;
  const FabCustom({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashIcon),
            fit: BoxFit.cover,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
