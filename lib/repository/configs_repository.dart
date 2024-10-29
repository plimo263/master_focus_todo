abstract class ConfigsRepository {
  Future<void> saveDarkMode(bool isDarkMode);
  Future<bool> isDarkMode();
  Future<void> savePomodoroSecondsTimeDefault(int totalSeconds);
  Future<int> getPomodoroSecondsTimeDefault();
  Future<void> saveShortBreakSecondsTimeDefault(int totalSeconds);
  Future<int> getShortBreakSecondsTimeDefault();

  Future<void> saveSoundClock(int sound);
  Future<int> getSoundClock();
}
