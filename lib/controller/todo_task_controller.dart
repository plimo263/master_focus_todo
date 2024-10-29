import 'package:flutter/foundation.dart';
import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/repository/todo_task_repository.dart';

class TodoTaskController extends ChangeNotifier {
  final List<TodoTask> todos = [];
  final TodoTaskRepository _repository;

  TodoTaskController(this._repository);

  Future<void> addTask(TodoTask task) async {
    task.id ??= TodoTask.generateId();
    await _repository.addTodoTask(task);
    todos.add(task);
    notifyListeners();
  }

  Future<void> deleteTask(TodoTask task) async {
    await _repository.deleteTodoTask(task);
    todos.remove(task);
    notifyListeners();
  }

  Future<List<TodoTask>> getTasks() async {
    if (todos.isEmpty) {
      todos.addAll(await _repository.getAllTodoTasks());
    }
    notifyListeners();
    return todos;
  }

  Future<void> updateTask(TodoTask task) async {
    await _repository.updateTodoTask(task);
    int index = todos.indexOf(task);
    if (index != -1) {
      todos[index] = task;
    }
    notifyListeners();
  }

  int getTotalTasks() {
    return todos.length;
  }

  int getTotalTasksCompleted() {
    return todos.where((task) => task.isCompleted).length;
  }

  int getTotalPomodoros() {
    return todos.fold(0, (total, task) => total + task.pomodoros);
  }

  int getTotalPomodorosCompleted() {
    return todos.fold(0, (total, task) => total + task.pomodoroCompleted);
  }

  int getTotalPomodorosNotCompleted() {
    final total = getTotalPomodoros();
    final completed = getTotalPomodorosCompleted();

    return total - completed;
  }

  String getTotalTime() {
    final timeConcluded = todos.fold(
      0,
      (total, task) =>
          total + (task.timerActual.secondsTotal * task.pomodoroCompleted),
    );

    final timeConcludedActual = todos.fold(
      0,
      (total, task) => total + task.timerActual.secondsElapsed,
    );

    final allTimeConcluded = timeConcluded + timeConcludedActual;

    final hours = (allTimeConcluded ~/ 3600).toString().padLeft(2, '0');
    int minutes = (allTimeConcluded ~/ 60);
    final seconds = (allTimeConcluded % 60).toInt().toString().padLeft(2, '0');
    if (minutes >= 60) {
      minutes = minutes % 60;
    }

    return '$hours:${minutes.toString().padLeft(2, '0')}:$seconds';
  }
}
