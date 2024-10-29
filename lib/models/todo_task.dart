import 'dart:convert';

import 'package:master_focus_todo/models/todo_timer.dart';
import 'package:master_focus_todo/models/user.dart';
import 'package:master_focus_todo/utils/dates.dart';
import 'package:uuid/v4.dart';

class TodoTask {
  String? id;
  final User user;
  final TodoTimer timerActual;
  final DateTime dateCreated;
  String description;
  int pomodoros;
  int pomodoroCompleted;
  bool isCompleted;

  TodoTask({
    this.id,
    required this.user,
    required this.description,
    required this.pomodoros,
    required this.pomodoroCompleted,
    required this.timerActual,
    required this.dateCreated,
    required this.isCompleted,
  });

  TodoTask.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        user = User.fromMap(map['user']),
        description = map['description'],
        pomodoros = map['pomodoros'],
        pomodoroCompleted = map['pomodoro_completed'],
        timerActual = TodoTimer.fromMap(map['timer_actual']),
        dateCreated = DateTime.parse(
          map['date_created'],
        ),
        isCompleted = map['is_completed'] ?? false;

  factory TodoTask.fromJson(String json) {
    final map = jsonDecode(json);
    return TodoTask.fromMap(map);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'description': description,
      'pomodoros': pomodoros,
      'pomodoro_completed': pomodoroCompleted,
      'timer_actual': timerActual.toMap(),
      'date_created': formatDate(dateCreated, 'yyyy-MM-dd HH:mm:ss'),
      'is_completed': isCompleted,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TodoTask) return false;
    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  static String generateId() {
    return const UuidV4().generate();
  }
}
