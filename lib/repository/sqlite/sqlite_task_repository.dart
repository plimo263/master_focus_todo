import 'package:master_focus_todo/database/task_table.dart';
import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/models/user.dart';
import 'package:master_focus_todo/repository/todo_task_repository.dart';
import 'package:sqflite/sqlite_api.dart';

class SqliteTaskRepository implements TodoTaskRepository {
  final Database _db;

  final _taskTable = TaskTable.instance;

  SqliteTaskRepository(this._db);

  Map<String, dynamic> _rowToMap(Map<String, dynamic> row) {
    return {
      'id': row['id'],
      'description': row['description'],
      'pomodoros': row['pomodoros'],
      'pomodoro_completed': row['pomodoro_completed'],
      'date_created': row['date_created'],
      'timer_actual': {
        'seconds_elapsed': row['seconds_elapsed'],
        'seconds_total': row['seconds_total'],
      },
      'user': {
        'id': row['user_id'],
        'name': row['user_name'],
      },
      'is_completed': row['is_completed'] == 1,
    };
  }

  @override
  Future<void> addTodoTask(TodoTask todoTask) async {
    final query = _taskTable.createRegisterQuey(todoTask);
    await _db.execute(query);
  }

  /// Recupera o usuário, lança uma exception caso não consiga encontra-lo
  User _getUser() {
    final user = User();
    if (user.id == null) {
      throw Exception('User not found or not authenticated');
    }
    return user;
  }

  @override
  Future<void> deleteAllTodoTasks() async {
    final user = _getUser();
    final query = _taskTable.deleteAllRegisterQuery(user.id!);
    await _db.execute(query);
  }

  @override
  Future<void> deleteTodoTask(TodoTask todoTask) async {
    final query = _taskTable.deleteRegisterQuery(todoTask);
    await _db.execute(query);
  }

  @override
  Future<List<TodoTask>> getAllTodoTasks() async {
    final user = _getUser();
    final query = _taskTable.getAllRegisterQuery(user.id!);
    final result = await _db.rawQuery(query);
    final tasks = <TodoTask>[];
    for (Map<String, dynamic> e in result) {
      final map = _rowToMap(e);
      tasks.add(TodoTask.fromMap(map));
    }

    return tasks;
  }

  @override
  Future<List<TodoTask>> getTodoTasksByDate(
    DateTime dateFrom,
    DateTime dateTo,
  ) async {
    final user = _getUser();
    final query =
        _taskTable.getTodoTasksByDateQuery(dateFrom, dateTo, user.id!);
    final result = await _db.rawQuery(query);
    final tasks = <TodoTask>[];
    for (Map<String, dynamic> e in result) {
      final map = _rowToMap(e);
      tasks.add(TodoTask.fromMap(map));
    }
    return tasks;
  }

  @override
  Future<void> updateTodoTask(TodoTask todoTask) async {
    final query = _taskTable.updateRegisterQuery(todoTask);
    await _db.execute(query);
  }
}
