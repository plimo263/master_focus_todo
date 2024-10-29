import 'package:flutter/material.dart';
import 'package:master_focus_todo/repository/configs_repository.dart';

class TodoConfigsController extends ChangeNotifier {
  bool _darkMode = false;
  int _pomodoroSecondsTimeDefault = 1500;
  int _saveShortBreakSecondsTimeDefault = 300;
  int _soundClock = 0;

  final ConfigsRepository _configsRepository;

  TodoConfigsController(this._configsRepository);

  Future<void> init() async {
    _darkMode = await _configsRepository.isDarkMode();
    _pomodoroSecondsTimeDefault =
        await _configsRepository.getPomodoroSecondsTimeDefault();
    _saveShortBreakSecondsTimeDefault =
        await _configsRepository.getShortBreakSecondsTimeDefault();
    _soundClock = await _configsRepository.getSoundClock();
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    await _configsRepository.saveDarkMode(value);
    _darkMode = value;
    notifyListeners();
  }

  Future<void> savePomodoroSecondsTimeDefault(int value) async {
    await _configsRepository.savePomodoroSecondsTimeDefault(value);
    _pomodoroSecondsTimeDefault = value;
    notifyListeners();
  }

  Future<void> saveShortBreakSecondsTimeDefault(int value) async {
    await _configsRepository.saveShortBreakSecondsTimeDefault(value);
    _saveShortBreakSecondsTimeDefault = value;
    notifyListeners();
  }

  bool get darkMode {
    return _darkMode;
  }

  int get pomodoroSecondsTimeDefault {
    return _pomodoroSecondsTimeDefault;
  }

  int get shortBreakSecondsTimeDefault {
    return _saveShortBreakSecondsTimeDefault;
  }

  int get soundClock {
    return _soundClock;
  }

  Future<void> saveSoundClock(int value) async {
    await _configsRepository.saveSoundClock(value);
    _soundClock = value;
    notifyListeners();
  }
}
