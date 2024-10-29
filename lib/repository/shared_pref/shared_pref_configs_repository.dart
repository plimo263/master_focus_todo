import 'package:master_focus_todo/repository/configs_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefConfigsRepository implements ConfigsRepository {
  SharedPreferences? _preferences;

  final String _table = 'configs';
  final String _pomodoroSecondsTime = 'pomodoro_seconds_time';
  final String _shortBreakSecondsTime = 'short_break_seconds_time';
  final String _darkMode = 'dark_mode';
  final String _soundClock = 'sound_clock';

  SharedPrefConfigsRepository([this._preferences]);

  Future<SharedPreferences> _getInstance() async {
    _preferences ??= await SharedPreferences.getInstance();
    return _preferences!;
  }

  @override
  Future<int> getPomodoroSecondsTimeDefault() async {
    final prefs = await _getInstance();
    return prefs.getInt('$_table-$_pomodoroSecondsTime') ?? 1500;
  }

  @override
  Future<int> getShortBreakSecondsTimeDefault() async {
    final prefs = await _getInstance();
    return prefs.getInt('$_table-$_shortBreakSecondsTime') ?? 300;
  }

  @override
  Future<bool> isDarkMode() async {
    final prefs = await _getInstance();
    return prefs.getBool('$_table-$_darkMode') ?? false;
  }

  @override
  Future<void> saveDarkMode(bool isDarkMode) async {
    final prefs = await _getInstance();
    await prefs.setBool('$_table-$_darkMode', isDarkMode);
  }

  @override
  Future<void> savePomodoroSecondsTimeDefault(int totalSeconds) async {
    final prefs = await _getInstance();
    await prefs.setInt('$_table-$_pomodoroSecondsTime', totalSeconds);
  }

  @override
  Future<void> saveShortBreakSecondsTimeDefault(int totalSeconds) async {
    final prefs = await _getInstance();
    await prefs.setInt('$_table-$_shortBreakSecondsTime', totalSeconds);
  }

  @override
  Future<int> getSoundClock() async {
    final prefs = await _getInstance();
    return prefs.getInt('$_table-$_soundClock') ?? 0;
  }

  @override
  Future<void> saveSoundClock(int sound) async {
    final prefs = await _getInstance();
    await prefs.setInt('$_table-$_soundClock', sound);
  }
}
