import 'package:flutter/material.dart';
import 'package:master_focus_todo/controller/todo_task_controller.dart';
import 'package:master_focus_todo/widgets/app_bar_custom.dart';
import 'package:master_focus_todo/widgets/board_value.dart';
import 'package:provider/provider.dart';

const strings = {
  'title_page_statistics': 'Estatísticas',
  'label_total_tasks': 'Total de tarefas',
  'label_tasks_done': 'Tarefas concluídas',
  'label_time_concluded': 'Tempo concluído',
  'label_total_pomodoros': 'Total de pomodoros',
  'label_total_pomodoros_not_concluded': 'Pomodoros não concluídos',
};

class StatisticsScreen extends StatelessWidget {
  static const routeName = 'statistics_screen';
  const StatisticsScreen({super.key});

  int _totalTasks(BuildContext context) {
    return Provider.of<TodoTaskController>(context, listen: false)
        .getTotalTasks();
  }

  int _tasksDone(BuildContext context) {
    return Provider.of<TodoTaskController>(context, listen: false)
        .getTotalTasksCompleted();
  }

  String _timeConcluded(BuildContext context) {
    final controller = Provider.of<TodoTaskController>(context, listen: false);
    return controller.getTotalTime();
  }

  int _totalPomodoros(BuildContext context) {
    final controller = Provider.of<TodoTaskController>(context, listen: false);
    return controller.getTotalPomodoros();
  }

  int _totalPomodorosNotConcluded(BuildContext context) {
    final controller = Provider.of<TodoTaskController>(context, listen: false);
    return controller.getTotalPomodorosNotCompleted();
  }

  double _widthBoard(BuildContext context) {
    return MediaQuery.of(context).size.width / 2 - 8;
  }

  double _widthFullBoard(BuildContext context) {
    return MediaQuery.of(context).size.width - 8;
  }

  int _darkIndicatorColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? 900 : 200;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: strings['title_page_statistics']!,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: _widthBoard(context),
                child: BoardValue(
                  label: strings['label_total_tasks']!,
                  value: _totalTasks(context).toString(),
                  backgroundColor: Colors.red[_darkIndicatorColor(context)],
                ),
              ),
              SizedBox(
                width: _widthBoard(context),
                child: BoardValue(
                  label: strings['label_tasks_done']!,
                  value: _tasksDone(context).toString(),
                  backgroundColor: Colors.green[_darkIndicatorColor(context)],
                ),
              ),
              SizedBox(
                width: _widthFullBoard(context),
                child: BoardValue(
                  label: strings['label_time_concluded']!,
                  value: _timeConcluded(context),
                  backgroundColor: Colors.blue[_darkIndicatorColor(context)],
                ),
              ),
              SizedBox(
                width: _widthBoard(context),
                child: BoardValue(
                  label: strings['label_total_pomodoros']!,
                  value: _totalPomodoros(context).toString(),
                  backgroundColor: Colors.orange[_darkIndicatorColor(context)],
                ),
              ),
              SizedBox(
                width: _widthBoard(context),
                child: BoardValue(
                  label: strings['label_total_pomodoros_not_concluded']!,
                  value: _totalPomodorosNotConcluded(context).toString(),
                  backgroundColor: Colors.purple[_darkIndicatorColor(context)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
