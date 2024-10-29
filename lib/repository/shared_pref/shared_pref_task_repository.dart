import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/repository/todo_task_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefTaskRepository implements TodoTaskRepository {
  SharedPreferences? _preferences;

  SharedPrefTaskRepository([this._preferences]);

  Future<SharedPreferences> _getInstance() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  @override
  Future<void> addTodoTask(TodoTask todoTask) async {
    final prefs = await _getInstance();
    final tasks = prefs.getStringList('tasks') ?? [];
    tasks.add(todoTask.toJson());
    await prefs.setStringList('tasks', tasks);
  }

  @override
  Future<void> deleteAllTodoTasks() async {
    final prefs = await _getInstance();
    await prefs.remove('tasks');
  }

  @override
  Future<void> deleteTodoTask(TodoTask todoTask) async {
    final prefs = await _getInstance();
    final tasks = prefs.getStringList('tasks') ?? [];
    tasks.remove(todoTask.toJson());
    await prefs.setStringList('tasks', tasks);
  }

  @override
  Future<List<TodoTask>> getAllTodoTasks() async {
    final prefs = await _getInstance();
    final tasks = prefs.getStringList('tasks') ?? [];
    return tasks.map((e) => TodoTask.fromJson(e)).toList();
  }

  @override
  Future<List<TodoTask>> getTodoTasksByDate(
      DateTime dateFrom, DateTime dateTo) async {
    final prefs = await _getInstance();
    final tasks = prefs.getStringList('tasks') ?? [];
    return tasks
        .map((e) => TodoTask.fromJson(e))
        .where((element) =>
            element.dateCreated.isAfter(dateFrom) &&
            element.dateCreated.isBefore(dateTo))
        .toList();
  }

  @override
  Future<void> updateTodoTask(TodoTask todoTask) async {
    final prefs = await _getInstance();
    final tasks = (prefs.getStringList('tasks') ?? [])
        .map((e) => TodoTask.fromJson(e))
        .toList();
    final index = tasks.indexWhere((element) => element.id == todoTask.id);
    tasks[index] = todoTask;
    final tasksToListString = tasks.map((e) => e.toJson()).toList();
    await prefs.setStringList('tasks', tasksToListString);
  }
}
