import 'package:flutter/material.dart';
import 'package:master_focus_todo/constants/images_path.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String tomatoImage;
  final List<Widget> actions;
  const AppBarCustom(
      {super.key,
      this.title,
      this.tomatoImage = tomatoGoodBye,
      this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset(tomatoImage, height: 30),
          const SizedBox(width: 8),
          title != null ? Text(title!) : const Text(''),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
