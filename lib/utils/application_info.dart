class ApplicationInfo {
  String versionName = "1.0.0";

  static ApplicationInfo instance = ApplicationInfo._();

  ApplicationInfo._();

  factory ApplicationInfo() {
    return instance;
  }
}
