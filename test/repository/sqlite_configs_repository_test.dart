import 'package:flutter_test/flutter_test.dart';
import 'package:master_focus_todo/database/db.dart';
import 'package:master_focus_todo/repository/sqlite/sqlite_configs_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'test_config.dart';

void main() {
  setupTestDatabase();

  late SqliteConfigsRepository repository;
  late Database db;

  setUp(() async {
    db = await getDatabase();
    repository = SqliteConfigsRepository(db);
  });

  test('SqliteConfigsRepository.getPomodoroSecondsTimeDefault', () async {
    // Arrange
    await repository.savePomodoroSecondsTimeDefault(1500);

    // Act
    final result = await repository.getPomodoroSecondsTimeDefault();

    // Assert
    expect(result, 1500);
  });

  test('SqliteConfigsRepository.getShortBreakSecondsTimeDefault', () async {
    // Arrange
    await repository.saveShortBreakSecondsTimeDefault(300);

    // Act
    final result = await repository.getShortBreakSecondsTimeDefault();

    // Assert
    expect(result, 300);
  });

  test('SqliteConfigsRepository.getSoundClock', () async {
    // Arrange
    await repository.saveSoundClock(1);

    // Act
    final result = await repository.getSoundClock();

    // Assert
    expect(result, 1);
  });

  test('SqliteConfigsRepository.isDarkMode', () async {
    // Arrange
    await repository.saveDarkMode(true);

    // Act
    final result = await repository.isDarkMode();

    // Assert
    expect(result, true);
  });

  test('SqliteConfigsRepository.saveDarkMode', () async {
    // Act
    await repository.saveDarkMode(true);
    final result = await repository.isDarkMode();

    // Assert
    expect(result, true);
  });

  test('SqliteConfigsRepository.savePomodoroSecondsTimeDefault', () async {
    // Act
    await repository.savePomodoroSecondsTimeDefault(1500);
    final result = await repository.getPomodoroSecondsTimeDefault();

    // Assert
    expect(result, 1500);
  });

  test('SqliteConfigsRepository.saveShortBreakSecondsTimeDefault', () async {
    // Act
    await repository.saveShortBreakSecondsTimeDefault(300);
    final result = await repository.getShortBreakSecondsTimeDefault();

    // Assert
    expect(result, 300);
  });

  test('SqliteConfigsRepository.saveSoundClock', () async {
    // Act
    await repository.saveSoundClock(1);
    final result = await repository.getSoundClock();

    // Assert
    expect(result, 1);
  });

  tearDown(() async {
    await db.close();
  });
}
