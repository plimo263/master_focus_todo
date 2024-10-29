import 'package:flutter_test/flutter_test.dart';
import 'package:master_focus_todo/controller/todo_configs_controller.dart';
import 'package:master_focus_todo/repository/configs_repository.dart';
import 'package:master_focus_todo/repository/shared_pref/shared_pref_configs_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/shared_pref_task_repository_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  late ConfigsRepository configsRepository;
  late TodoConfigsController todoConfigsController;

  setUp(() {
    configsRepository = SharedPrefConfigsRepository(mockSharedPreferences);
    todoConfigsController = TodoConfigsController(configsRepository);
    when(mockSharedPreferences.getBool('darkMode')).thenReturn(true);
    when(mockSharedPreferences.getInt('pomodoroSecondsTimeDefault'))
        .thenReturn(1500);
    when(mockSharedPreferences.getInt('shortBreakSecondsTimeDefault'))
        .thenReturn(300);
  });

  group('TodoConfigsController Tests', () {
    test('should initialize with values from repository', () async {
      await todoConfigsController.init();

      expect(todoConfigsController.darkMode, true);
      expect(todoConfigsController.pomodoroSecondsTimeDefault, 1800);
      expect(todoConfigsController.shortBreakSecondsTimeDefault, 600);
    });

    test('should set dark mode and notify listeners', () async {
      await todoConfigsController.setDarkMode(true);

      verify(configsRepository.saveDarkMode(true)).called(1);
      expect(todoConfigsController.darkMode, true);
    });

    test('should save Pomodoro default time and notify listeners', () async {
      await todoConfigsController.savePomodoroSecondsTimeDefault(2000);

      verify(configsRepository.savePomodoroSecondsTimeDefault(2000)).called(1);
      expect(todoConfigsController.pomodoroSecondsTimeDefault, 2000);
    });

    test('should save short break default time and notify listeners', () async {
      await todoConfigsController.saveShortBreakSecondsTimeDefault(400);

      verify(configsRepository.saveShortBreakSecondsTimeDefault(400)).called(1);
      expect(todoConfigsController.shortBreakSecondsTimeDefault, 400);
    });
  });
}
