import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:master_focus_todo/controller/todo_configs_controller.dart';
import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/models/todo_timer.dart';
import 'package:master_focus_todo/models/user.dart';
import 'package:master_focus_todo/screens/focus_details_screen.dart';
import 'package:master_focus_todo/screens/focus_screen.dart';
import 'package:master_focus_todo/screens/form_task_screen.dart';
import 'package:master_focus_todo/controller/todo_task_controller.dart';
import 'package:master_focus_todo/screens/splash_screen.dart';
import 'package:master_focus_todo/utils/bottom_sheet_custom.dart';
import 'package:master_focus_todo/utils/snack_bar.dart';
import 'package:master_focus_todo/widgets/app_bar_custom.dart';
import 'package:master_focus_todo/widgets/confirm_widget.dart';
import 'package:master_focus_todo/widgets/no_data_widget.dart';
import 'package:master_focus_todo/widgets/todo_task_widget.dart';
import 'package:provider/provider.dart';

final strings = {
  'app_title': 'Master Focus Todo',
  'title_delete': 'Deletar tarefa',
  'subtitle_delete': 'Deseja realmente deletar esta tarefa ?',
  'task_completed': 'Esta tarefa já foi concluída',
  'no_task_found':
      'Nenhuma tarefa encontrada, clique no + para uma nova tarefa',
};

class FocusListScreen extends StatefulWidget {
  static const routeName = 'focus_list_screen';
  const FocusListScreen({super.key});

  @override
  State<FocusListScreen> createState() => _FocusListScreenState();
}

class _FocusListScreenState extends State<FocusListScreen> {
  final _user = User();
  int _totalSecondsDefault = 1500;

  @override
  void initState() {
    super.initState();
    initTasks();
  }

  void initTasks() async {
    final service = Provider.of<TodoTaskController>(context, listen: false);
    final configsController =
        Provider.of<TodoConfigsController>(context, listen: false);
    Future.microtask(() async {
      await service.getTasks();
      _totalSecondsDefault = configsController.pomodoroSecondsTimeDefault;
    });
  }

  // Ver detalhes do foco
  void _viewTask(BuildContext context, TodoTask task) {
    Navigator.of(context).pushNamed(
      FocusDetailsScreen.routeName,
      arguments: task,
    );
  }

  // Deleta a tarefa
  void _deleteTask(BuildContext context, TodoTask task) {
    getBottomSheet(
      context,
      Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ConfirmWidget(
          title: strings['title_delete']!,
          subtitle: strings['subtitle_delete']!,
          onConfirm: () {
            Navigator.pop(context, true);
          },
          onCancel: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      minHeight: .3,
      maxHeight: .3,
    ).then((response) {
      if (response) {
        final service = Provider.of<TodoTaskController>(context, listen: false);
        service.deleteTask(task);
      }
    });
  }

  // Edita a tarefa
  void _editTask(BuildContext context, TodoTask task) {
    getBottomSheet(context, FormTaskScreen(task: task)).then((value) {
      if (value != null) {
        final taskUpdate = _getNewTodoTask(value);
        final service = Provider.of<TodoTaskController>(context, listen: false);
        service.updateTask(taskUpdate);
      }
    });
  }

  // Inicia o processo de foco
  void _startFocus(BuildContext context, TodoTask task) {
    if (task.isCompleted) {
      snackInfo(strings['task_completed']!);
      return;
    }

    Navigator.of(context)
        .pushNamed<dynamic>(FocusScreen.routeName, arguments: task)
        .then((taskActualy) async {
      if (taskActualy != null) {
        final service = Provider.of<TodoTaskController>(context, listen: false);
        await service.updateTask(taskActualy as TodoTask);
      }
    });
  }

  // Retorna uma nova tarefa a partir de um Map
  TodoTask _getNewTodoTask(Map<String, dynamic> value) {
    return TodoTask(
      id: value['id'],
      user: _user,
      description: value['description'],
      pomodoros: value['totalTomatos'],
      pomodoroCompleted: value['tomatoFinished'],
      timerActual: TodoTimer(
        secondsTotal: _totalSecondsDefault,
        secondsElapsed: 0,
      ),
      dateCreated: value['date_created'],
      isCompleted: value['isCompleted'],
    );
  }

  // Inicia a intenção de criar uma nova tarefa
  void _createTask(BuildContext context) {
    getBottomSheet(context, const FormTaskScreen()).then((value) {
      if (value != null) {
        final newTask = _getNewTodoTask(value);
        final service = Provider.of<TodoTaskController>(context, listen: false);
        service.addTask(newTask);
      }
    });
  }

  _logout() {
    auth.FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pushReplacementNamed(SplashScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: strings['app_title']!,
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<TodoTaskController>(
        builder: (context, todoController, child) {
          final todos = todoController.todos;
          return todos.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: NoDataWidget(
                      message: strings['no_task_found']!,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final task = todos[index];
                    return TodoTaskWidget(
                      task: task,
                      onView: _viewTask,
                      onEdit: _editTask,
                      onDelete: _deleteTask,
                      onStart: _startFocus,
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
