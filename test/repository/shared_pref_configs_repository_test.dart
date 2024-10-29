import 'package:flutter_test/flutter_test.dart';
import 'package:master_focus_todo/repository/shared_pref/shared_pref_configs_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPrefConfigsRepository repository;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    repository = SharedPrefConfigsRepository();
  });

  test('SharedPrefConfigsRepository.savePomodoroSecondsTimeDefault', () async {
    await repository.savePomodoroSecondsTimeDefault(1500);
    final result = await repository.getPomodoroSecondsTimeDefault();
    expect(result, 1500);
  });

  test('SharedPrefConfigsRepository.saveShortBreakSecondsTimeDefault',
      () async {
    await repository.saveShortBreakSecondsTimeDefault(300);
    final result = await repository.getShortBreakSecondsTimeDefault();
    expect(result, 300);
  });

  test('SharedPrefConfigsRepository.saveDarkMode', () async {
    await repository.saveDarkMode(true);
    final result = await repository.isDarkMode();
    expect(result, true);
  });

  test('SharedPrefConfigsRepository.defaultValues', () async {
    final pomodoroTime = await repository.getPomodoroSecondsTimeDefault();
    final shortBreakTime = await repository.getShortBreakSecondsTimeDefault();
    final darkMode = await repository.isDarkMode();

    expect(pomodoroTime, 1500); // Assuming 1500 is the default value
    expect(shortBreakTime, 300); // Assuming 300 is the default value
    expect(darkMode, false); // Assuming false is the default value
  });

  test('SharedPrefConfigsRepository.saveSoundClock', () async {
    await repository.saveSoundClock(0);
    final result = await repository.getSoundClock();
    expect(result, 0);
  });

  test('SharedPrefConfigsRepository.saveSoundClock', () async {
    await repository.saveSoundClock(1);
    final result = await repository.getSoundClock();
    expect(result, 1);
  });
}
