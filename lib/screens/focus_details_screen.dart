import 'package:flutter/material.dart';
import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/utils/dates.dart';
import 'package:master_focus_todo/widgets/app_bar_custom.dart';

const strings = {
  'title': 'Detalhes do Foco',
  'label_description': 'Descrição',
  'label_date_created': 'Tarefa criada',
  'label_pomodoros': 'Pomodoros Previstos',
  'label_pomodoros_completed': 'Pomodoros Completados',
  'label_is_completed': 'Tarefa concluída ?',
};

class FocusDetailsScreen extends StatelessWidget {
  static const routeName = 'focus_details_screen';
  final TodoTask task;
  const FocusDetailsScreen({
    super.key,
    required this.task,
  });

  List<Map<String, dynamic>> _getDetails() {
    return [
      {
        'icon': Icons.description,
        'label': strings['label_description']!,
        'value': task.description,
      },
      {
        'icon': Icons.date_range,
        'label': strings['label_date_created']!,
        'value': formatDate(task.dateCreated, 'dd/MM/yy HH:mm:ss', true),
      },
      {
        'icon': Icons.timer,
        'label': strings['label_pomodoros']!,
        'value': '${task.pomodoros}',
      },
      {
        'icon': Icons.check,
        'label': strings['label_pomodoros_completed']!,
        'value': '${task.pomodoroCompleted}',
      },
      {
        'icon':
            task.isCompleted ? Icons.thumb_up_sharp : Icons.thumb_down_sharp,
        'label': strings['label_is_completed']!,
        'value': task.isCompleted ? 'Sim' : 'Não',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: strings['title']!,
      ),
      body: ListView(
        children: _getDetails()
            .map((e) => _FocusDetailsInfo(
                  icon: e['icon'],
                  label: e['label'],
                  value: e['value'],
                ))
            .toList(),
      ),
    );
  }
}

class _FocusDetailsInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _FocusDetailsInfo({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
