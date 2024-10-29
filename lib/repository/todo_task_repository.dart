import 'package:master_focus_todo/models/todo_task.dart';

abstract class TodoTaskRepository {
  Future<List<TodoTask>> getAllTodoTasks();

  Future<void> addTodoTask(TodoTask todoTask);

  Future<void> updateTodoTask(TodoTask todoTask);

  Future<void> deleteTodoTask(TodoTask todoTask);

  Future<void> deleteAllTodoTasks();

  Future<List<TodoTask>> getTodoTasksByDate(DateTime dateFrom, DateTime dateTo);
}
