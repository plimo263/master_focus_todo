import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/utils/dates.dart';

class TaskTable {
  final String id = 'id';
  final String description = 'description';
  final String pomodoros = 'pomodoros';
  final String pomodoroCompleted = 'pomodoro_completed';
  final String dateCreated = 'date_created';
  final String secondsElapsed = 'seconds_elapsed';
  final String secondsTotal = 'seconds_total';
  final String userId = 'user_id';
  final String userName = 'user_name';
  final String isCompleted = 'is_completed';

  final String table = 'task';

  static const TaskTable instance = TaskTable._();

  const TaskTable._();

  factory TaskTable() => instance;

  String get createTableQuery => '''
    CREATE TABLE $table (
      $id TEXT PRIMARY KEY,
      $description TEXT NOT NULL,
      $pomodoros INTEGER NOT NULL,
      $pomodoroCompleted INTEGER NOT NULL,
      $dateCreated TEXT NOT NULL,
      $secondsElapsed INTEGER NOT NULL,
      $secondsTotal INTEGER NOT NULL,
      $userId TEXT NOT NULL,
      $userName TEXT NOT NULL,
      $isCompleted INTEGER DEFAULT 0
    )
  ''';

  String get dropTableQuery => '''
    DROP TABLE IF EXISTS $table
  ''';

  String createRegisterQuey(TodoTask task) {
    final mapTimer = task.timerActual.toMap();

    return '''
      INSERT INTO $table (
        $id,
        $description,
        $pomodoros,
        $pomodoroCompleted,
        $dateCreated,
        $secondsElapsed,
        $secondsTotal,
        $userId,
        $userName,
        $isCompleted
      ) VALUES (
        '${task.id}',
        '${task.description}',
        ${task.pomodoros},
        ${task.pomodoroCompleted},
        '${formatDate(task.dateCreated, 'yyyy-MM-dd HH:mm:ss')}',
        ${mapTimer['seconds_elapsed']},
        ${mapTimer['seconds_total']},
        '${task.user.id}',
        '${task.user.name}',
        ${task.isCompleted ? 1 : 0}
      )
    ''';
  }

  String deleteAllRegisterQuery(String idUser) {
    return '''
      DELETE FROM $table WHERE $userId = '$idUser' 
    ''';
  }

  String deleteRegisterQuery(TodoTask task) {
    return '''
      DELETE FROM $table WHERE $id = '${task.id}'
    ''';
  }

  String getAllRegisterQuery(String idUser) {
    return '''
      SELECT * FROM $table WHERE $userId = '$idUser'
    ''';
  }

  String updateRegisterQuery(TodoTask task) {
    final mapTimer = task.timerActual.toMap();

    return '''
      UPDATE $table SET
        $description = '${task.description}',
        $pomodoros = ${task.pomodoros},
        $pomodoroCompleted = ${task.pomodoroCompleted},
        $dateCreated = '${formatDate(task.dateCreated, 'yyyy-MM-dd HH:mm:ss')}',
        $secondsElapsed = ${mapTimer['seconds_elapsed']},
        $secondsTotal = ${mapTimer['seconds_total']},
        $userId = '${task.user.id}',
        $userName = '${task.user.name}',
        $isCompleted = ${task.isCompleted ? 1 : 0}
      WHERE $id = '${task.id}'
    ''';
  }

  String getTodoTasksByDateQuery(DateTime start, DateTime end, String idUser) {
    return '''
      SELECT * FROM $table 
        WHERE $userId = '$idUser' AND 
          $dateCreated BETWEEN 
            '${formatDate(start, 'yyyy-MM-dd 00:00:00')}' AND 
            '${formatDate(end, 'yyyy-MM-dd 23:59:59')}' 
    ''';
  }
}
