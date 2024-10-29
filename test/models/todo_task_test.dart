import 'package:flutter_test/flutter_test.dart';
import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/models/todo_timer.dart';
import 'package:master_focus_todo/models/user.dart';
import 'package:master_focus_todo/utils/dates.dart';

void main() {
  late String id;
  setUpAll(() {
    id = TodoTask.generateId();
  });
  test('TodoTask', () {
    final user = User();
    user.id = '1';
    user.name = 'Marcos';

    final task = TodoTask(
        id: id,
        user: user,
        description: 'Arrumar os testes',
        pomodoros: 5,
        pomodoroCompleted: 0,
        timerActual: TodoTimer(secondsElapsed: 0, secondsTotal: 60 * 25),
        dateCreated: DateTime.now(),
        isCompleted: false);
    expect(task, isA<TodoTask>());
  });

  test('TodoTask.fromMap', () {
    final task = TodoTask.fromMap({
      'id': id,
      'user': {'id': '1', 'name': 'Marcos'},
      'description': 'Arrumar os testes',
      'pomodoros': 5,
      'pomodoro_completed': 0,
      'timer_actual': {'seconds_elapsed': 0, 'seconds_total': 60 * 25},
      'date_created': DateTime.now().toString(),
      'is_completed': false
    });
    expect(task, isA<TodoTask>());
  });

  test('TodoTask.fromJson', () {
    final task = TodoTask.fromJson(
      '{"id": "$id", "user": {"id": "1", "name": "Marcos"}, "description": "Arrumar os testes", "pomodoros": 5, "pomodoro_completed": 0, "timer_actual": {"seconds_elapsed": 0, "seconds_total": 1500}, "date_created": "${DateTime.now().toString()}", "is_completed": false}',
    );
    expect(task, isA<TodoTask>());
  });

  test('TodoTask.toMap', () {
    final dateCreated = DateTime.now();
    final user = User();
    user.id = '1';
    user.name = 'Marcos';

    final task = TodoTask(
        id: id,
        user: user,
        description: 'Arrumar os testes',
        pomodoros: 5,
        pomodoroCompleted: 0,
        timerActual: TodoTimer(secondsElapsed: 0, secondsTotal: 60 * 25),
        dateCreated: dateCreated,
        isCompleted: false);
    expect(task.toMap(), {
      'id': id,
      'user': {'id': '1', 'name': 'Marcos'},
      'description': 'Arrumar os testes',
      'pomodoros': 5,
      'pomodoro_completed': 0,
      'timer_actual': {'seconds_elapsed': 0, 'seconds_total': 60 * 25},
      'date_created': formatDate(dateCreated, 'yyyy-MM-dd HH:mm:ss'),
      'is_completed': false
    });
  });

  test('TodoTask.toJson', () {
    final dateCreated = DateTime.now();
    final user = User();
    user.id = '1';
    user.name = 'Marcos';

    final task = TodoTask(
        id: id,
        user: user,
        description: 'Arrumar os testes',
        pomodoros: 5,
        pomodoroCompleted: 0,
        timerActual: TodoTimer(secondsElapsed: 0, secondsTotal: 60 * 25),
        dateCreated: dateCreated,
        isCompleted: false);

    expect(task.toJson(),
        '{"id":"$id","user":{"id":"1","name":"Marcos"},"description":"Arrumar os testes","pomodoros":5,"pomodoro_completed":0,"timer_actual":{"seconds_total":1500,"seconds_elapsed":0},"date_created":"${formatDate(dateCreated, 'yyyy-MM-dd HH:mm:ss')}","is_completed":false}');
  });

  test('Todo.generateId', () {
    final String id = TodoTask.generateId();
    expect(id, isA<String>());
  });
}
