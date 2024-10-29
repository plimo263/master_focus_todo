import 'package:flutter_test/flutter_test.dart';
import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/models/todo_timer.dart';
import 'package:master_focus_todo/models/user.dart';
import 'package:master_focus_todo/repository/shared_pref/shared_pref_task_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';

import 'shared_pref_task_repository_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late SharedPrefTaskRepository repository;
  late User user;
  late TodoTask todoTask;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();

    repository = SharedPrefTaskRepository(mockSharedPreferences);

    user = User();
    user.id = '1';
    user.name = 'Marcos';

    todoTask = TodoTask(
      user: user,
      description: 'Arrumar os testes',
      pomodoros: 5,
      pomodoroCompleted: 0,
      timerActual: TodoTimer(secondsElapsed: 0, secondsTotal: 60 * 25),
      dateCreated: DateTime.now(),
      isCompleted: false,
    );
    //
    when(mockSharedPreferences.getStringList('tasks'))
        .thenReturn([todoTask.toJson()]);
    when(mockSharedPreferences.setStringList(any, any))
        .thenAnswer((_) async => true);
    when(mockSharedPreferences.remove(any)).thenAnswer((_) async => true);
  });

  test('SharedPrefTaskRepository.addTodoTask', () async {
    when(mockSharedPreferences.getStringList('tasks'))
        .thenReturn([todoTask.toJson()]);

    await repository.addTodoTask(todoTask);
    // Add assertions to verify the task was added
  });

  test('SharedPrefTaskRepository.deleteAllTodoTasks', () async {
    await repository.deleteAllTodoTasks();
    // Add assertions to verify all tasks were deleted
  });

  test('SharedPrefTaskRepository.deleteTodoTask', () async {
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

    await repository.deleteTodoTask(todoTask);
    // Add assertions to verify the task was deleted
  });

  test('SharedPrefTaskRepository.getAllTodoTasks', () async {
    await repository.getAllTodoTasks();
    // Add assertions to verify the tasks were retrieved
  });

  test('SharedPrefTaskRepository.getTodoTasksByDate', () async {
    final dateFrom = DateTime.now().subtract(const Duration(days: 1));
    final dateTo = DateTime.now();
    final tasks = await repository.getTodoTasksByDate(dateFrom, dateTo);
    // Add assertions to verify the tasks were retrieved within the date range
    expect(tasks, isA<List<TodoTask>>());
  });

  test('SharedPrefTaskRepository.updateTodoTask', () async {
    await repository.updateTodoTask(todoTask);
    // Add assertions to verify the task was updated
  });
}
