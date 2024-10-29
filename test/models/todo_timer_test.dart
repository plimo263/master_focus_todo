import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:master_focus_todo/models/todo_timer.dart';

void main() {
  final todoTimer = TodoTimer(secondsElapsed: 0, secondsTotal: 30);

  test('Teste de tipo', () {
    expect(todoTimer.runtimeType, TodoTimer);
  });

  test('TodoTimer.fromMap', () {
    expect(
        TodoTimer.fromMap({
          'seconds_elapsed': 0,
          'seconds_total': 30,
        }),
        isA<TodoTimer>());
  });

  test('TodoTimer.fromJson', () {
    expect(TodoTimer.fromJson('{"seconds_elapsed": 0, "seconds_total": 30}'),
        isA<TodoTimer>());
  });

  test('TodoTimer.toMap', () {
    final t = TodoTimer(secondsElapsed: 0, secondsTotal: 30);
    expect(t.toMap(), {
      'seconds_total': 30,
      'seconds_elapsed': 0,
    });
  });

  test('TodoTimer.remainingTime', () {
    expect(todoTimer.remainingTime(), 30);
  });

  test('TodoTimer.calculateMinutes', () {
    expect(todoTimer.calculateMinutes(120), 2);
    expect(todoTimer.calculateMinutes(60), 1);
    expect(todoTimer.calculateMinutes(75), 1);
  });
  test('TodoTimer.calculateSeconds', () {
    expect(todoTimer.calculateSeconds(120), 0);
    expect(todoTimer.calculateSeconds(60), 0);
    expect(todoTimer.calculateSeconds(75), 15);
  });

  test('TodoTimer.formatTime', () {
    expect(todoTimer.formatTime(60), '01:00');
    expect(todoTimer.formatTime(75), '01:15');
    expect(todoTimer.formatTime(90), '01:30');
    expect(todoTimer.formatTime(120), '02:00');
    expect(todoTimer.formatTime(121), '02:01');
  });

  test('TodoTimer.ticTac', () {
    final t = TodoTimer(secondsElapsed: 29, secondsTotal: 30);
    t.isRunning = true;
    t.ticTac();
    expect(t.remainingTime(), 0);
    expect(() => t.ticTac(), throwsA(isA<TimeoutException>()));
  });

  test('TodoTimer.reset', () {
    final t = TodoTimer(secondsElapsed: 29, secondsTotal: 30);
    t.reset();
    expect(t.remainingTime(), 30);
  });

  test('TodoTimer.toJson', () {
    final t = TodoTimer(secondsElapsed: 0, secondsTotal: 30);
    expect(t.toJson(), '{"seconds_total":30,"seconds_elapsed":0}');
  });
}
