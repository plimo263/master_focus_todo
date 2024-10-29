import 'package:master_focus_todo/database/configs_table.dart';
import 'package:master_focus_todo/database/task_table.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase([
  String databasePath = inMemoryDatabasePath,
]) async {
  final db = await openDatabase(
    databasePath,
    version: 1,
    onCreate: (db, version) async {
      // Tabela de tarefas
      await db.execute(
        TaskTable().createTableQuery,
      );

      // Tabela de configurações
      await db.execute(
        ConfigsTable().createTableQuery,
      );
    },
    onUpgrade: (db, oldVersion, newVersion) async {},
  );

  return db;
}
