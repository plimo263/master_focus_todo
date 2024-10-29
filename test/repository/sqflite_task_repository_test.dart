import 'package:flutter_test/flutter_test.dart';
import 'package:master_focus_todo/database/db.dart';
import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/models/todo_timer.dart';
import 'package:master_focus_todo/models/user.dart';
import 'package:master_focus_todo/repository/sqlite/sqlite_task_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'test_config.dart';

void main() {
  setupTestDatabase();

  late SqliteTaskRepository repository;
  late Database db;

  final user = User();
  user.id = '1';
  user.name = 'Marcos';

  final todoTask = TodoTask(
    id: TodoTask.generateId(),
    user: user,
    description: 'Arrumar os testes',
    pomodoros: 5,
    pomodoroCompleted: 0,
    timerActual: TodoTimer(secondsElapsed: 0, secondsTotal: 60 * 25),
    dateCreated: DateTime.now(),
    isCompleted: false,
  );

  setUp(() async {
    db = await getDatabase();
    repository = SqliteTaskRepository(db);
  });

  test('SqliteTaskRepository.addTodoTask', () async {
    await repository.addTodoTask(todoTask);
  });

  test('SqliteTaskRepository.deleteAllTodoTasks', () async {
    await repository.deleteAllTodoTasks();
    final tasks = await repository.getAllTodoTasks();
    expect(tasks.length, 0);
  });

  test('SqliteTodoTask.deleteTodoTask', () async {
    await repository.addTodoTask(todoTask);
    final task = await repository.getAllTodoTasks();
    await repository.deleteTodoTask(task.first);
  });

  test('SqliteTaskRepository.getAllTodoTasks', () async {
    await repository.addTodoTask(todoTask);
    final tasks = await repository.getAllTodoTasks();
    expect(tasks.length, 1);
  });

  test('SqliteTodoTask.getTodoTasksByDate', () async {
    await repository.addTodoTask(todoTask);
    final tasks =
        await repository.getTodoTasksByDate(DateTime.now(), DateTime.now());
    expect(tasks.length, 1);
  });

  test('SqliteTodoTask.updateTodoTask', () async {
    await repository.addTodoTask(todoTask);
    final tasks = await repository.getAllTodoTasks();
    final task = tasks.first;
    task.description = 'Arrumar os testes - Atualizado';
    await repository.updateTodoTask(task);
    final updatedTasks = await repository.getAllTodoTasks();
    expect(updatedTasks.first.description, 'Arrumar os testes - Atualizado');
  });

  tearDown(() async {
    await db.close();
  });
}
