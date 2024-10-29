import 'package:flutter/material.dart';
import 'package:master_focus_todo/constants/sounds_path.dart';
import 'package:master_focus_todo/controller/todo_configs_controller.dart';
import 'package:master_focus_todo/screens/configs/form_save_time_seconds.dart';
import 'package:master_focus_todo/screens/configs/form_sound.dart';
import 'package:master_focus_todo/utils/bottom_sheet_custom.dart';
import 'package:master_focus_todo/utils/dates.dart';
import 'package:master_focus_todo/widgets/app_bar_custom.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

const strings = {
  'title': 'Configurações',
  'label_dark_mode': 'Modo Claro / Escuro',
  'label_pomodoro_time_default': 'Tempo Padrão do Pomodoro',
  'label_short_break_time_default': 'Tempo Padrão da Pausa Curta',
  'title_form_short_break_time_default': 'Tempo Padrão da Pausa Curta',
  'subtitle_form_short_break_time_default':
      'Defina um tempo padrão para a Pausa Curta',
  'title_form_sound_default': 'Som Padrão para as tarefas',
};

class ConfigsScreen extends StatefulWidget {
  static const routeName = 'config_screen';
  const ConfigsScreen({super.key});

  @override
  State<ConfigsScreen> createState() => _ConfigsScreenState();
}

class _ConfigsScreenState extends State<ConfigsScreen> {
  void _toggleDarkMode(bool? value) {
    if (value != null) {
      final configsController =
          Provider.of<TodoConfigsController>(context, listen: false);
      configsController.setDarkMode(value);
    }
  }

  Future<void> _editPomodoroTimeDefault() async {
    final configsController =
        Provider.of<TodoConfigsController>(context, listen: false);
    getBottomSheet<int?>(
      context,
      FormSaveTimeSeconds(
        seconds: configsController.pomodoroSecondsTimeDefault,
      ),
      minHeight: 0.3,
      maxHeight: 0.5,
    ).then((value) {
      if (value != null) {
        configsController.savePomodoroSecondsTimeDefault(value);
      }
    });
  }

  Future<void> _editShortBreakTimeDefault() async {
    final configsController =
        Provider.of<TodoConfigsController>(context, listen: false);
    getBottomSheet<int?>(
      context,
      FormSaveTimeSeconds(
        seconds: configsController.shortBreakSecondsTimeDefault,
      ),
      minHeight: 0.3,
      maxHeight: 0.5,
    ).then((value) {
      if (value != null) {
        configsController.saveShortBreakSecondsTimeDefault(value);
      }
    });
  }

  Future<void> _editSoundDefault() async {
    final configsController =
        Provider.of<TodoConfigsController>(context, listen: false);
    getBottomSheet<int?>(
      context,
      FormSound(
        soundDefault: configsController.soundClock,
        onTap: (value) {
          Navigator.of(context).pop(value);
        },
      ),
      minHeight: 0.3,
      maxHeight: 0.5,
    ).then((value) {
      if (value != null) {
        configsController.saveSoundClock(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final configsController =
        Provider.of<TodoConfigsController>(context, listen: true);
    return Scaffold(
      appBar: const AppBarCustom(
        title: 'Configs',
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(strings['label_dark_mode']!),
            trailing: Switch(
              value: configsController.darkMode,
              onChanged: _toggleDarkMode,
            ),
          ),
          GestureDetector(
            onTap: _editPomodoroTimeDefault,
            child: ListTile(
              title: Text(strings['label_pomodoro_time_default']!),
              subtitle: Text(
                formatSeconds(configsController.pomodoroSecondsTimeDefault),
              ),
            ),
          ),
          GestureDetector(
            onTap: _editShortBreakTimeDefault,
            child: ListTile(
              title: Text(strings['label_short_break_time_default']!),
              subtitle: Text(
                formatSeconds(configsController.shortBreakSecondsTimeDefault),
              ),
            ),
          ),
          GestureDetector(
            onTap: _editSoundDefault,
            child: ListTile(
              title: Text(strings['title_form_sound_default']!),
              subtitle: Text(
                path.basenameWithoutExtension(
                    sounds[configsController.soundClock]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
