import 'package:master_focus_todo/database/configs_table.dart';
import 'package:master_focus_todo/repository/configs_repository.dart';
import 'package:sqflite/sqflite.dart';

class SqliteConfigsRepository implements ConfigsRepository {
  final Database _database;
  final ConfigsTable _configsTable = ConfigsTable();
  final _pomodoroSecondsTimeDefaultKey = 'pomodoro_seconds_time_default';
  final _pomodoroShortBreakTimeDefaultKey = 'pomodoro_short_break_time_default';
  final _soundClockKey = 'sound_clock';
  final _darkModeKey = 'dark_mode';

  SqliteConfigsRepository(this._database);

  @override
  Future<int> getPomodoroSecondsTimeDefault() async {
    final query =
        _configsTable.selectByKeyQuery(_pomodoroSecondsTimeDefaultKey);
    final register = await _database.rawQuery(query);
    if (register.isEmpty) {
      return 1500;
    }
    return int.parse(register.first[_configsTable.columnValue] as String);
  }

  @override
  Future<int> getShortBreakSecondsTimeDefault() async {
    final query =
        _configsTable.selectByKeyQuery(_pomodoroShortBreakTimeDefaultKey);
    final register = await _database.rawQuery(query);
    if (register.isEmpty) {
      return 300;
    }
    return int.parse(register.first[_configsTable.columnValue] as String);
  }

  @override
  Future<int> getSoundClock() async {
    final query = _configsTable.selectByKeyQuery(_soundClockKey);
    final register = await _database.rawQuery(query);
    if (register.isEmpty) {
      return 0;
    }
    return int.parse(register.first[_configsTable.columnValue] as String);
  }

  @override
  Future<bool> isDarkMode() async {
    final query = _configsTable.selectByKeyQuery(_darkModeKey);
    final register = await _database.rawQuery(query);
    if (register.isEmpty) {
      return false;
    }
    return register.first[_configsTable.columnValue] == '1';
  }

  @override
  Future<void> saveDarkMode(bool isDarkMode) async {
    final query = _configsTable.upInsertByKeyQuery(
      _darkModeKey,
      isDarkMode ? '1' : '0',
    );
    await _database.rawInsert(query);
  }

  @override
  Future<void> savePomodoroSecondsTimeDefault(int totalSeconds) async {
    final query = _configsTable.upInsertByKeyQuery(
      _pomodoroSecondsTimeDefaultKey,
      totalSeconds.toString(),
    );
    await _database.rawInsert(query);
  }

  @override
  Future<void> saveShortBreakSecondsTimeDefault(int totalSeconds) async {
    final query = _configsTable.upInsertByKeyQuery(
      _pomodoroShortBreakTimeDefaultKey,
      totalSeconds.toString(),
    );
    await _database.rawInsert(query);
  }

  @override
  Future<void> saveSoundClock(int sound) async {
    final query = _configsTable.upInsertByKeyQuery(
      _soundClockKey,
      sound.toString(),
    );
    await _database.rawInsert(query);
  }
}
