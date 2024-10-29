import 'package:flutter/material.dart';
import 'package:master_focus_todo/constants/sounds_path.dart';
import 'package:master_focus_todo/controller/todo_configs_controller.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

const strings = {
  'sound_playing': 'Tocando',
};

class MusicPlaying extends StatelessWidget {
  const MusicPlaying({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headlineSmall;

    return Consumer<TodoConfigsController>(
      builder: (context, controller, child) {
        return Text(
          '${strings['sound_playing']}: ${path.basenameWithoutExtension(sounds[controller.soundClock])}',
          style: textStyle,
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
