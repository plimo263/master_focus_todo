import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:master_focus_todo/constants/db_path.dart';
import 'package:master_focus_todo/controller/todo_configs_controller.dart';
import 'package:master_focus_todo/database/db.dart';
import 'package:master_focus_todo/firebase_options.dart';
import 'package:master_focus_todo/controller/todo_task_controller.dart';
import 'package:master_focus_todo/repository/sqlite/sqlite_configs_repository.dart';
import 'package:master_focus_todo/repository/sqlite/sqlite_task_repository.dart';
import 'package:master_focus_todo/screens/routes.dart';
import 'package:master_focus_todo/screens/splash_screen.dart';
import 'package:master_focus_todo/theme/dart_theme.dart';
import 'package:master_focus_todo/theme/light_theme.dart';
import 'package:master_focus_todo/utils/application_info.dart';
import 'package:master_focus_todo/utils/contexts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

Future<void> setAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  final appInfo = ApplicationInfo();
  appInfo.versionName = packageInfo.version;
}

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setAppVersion();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  final appDocDir = await getApplicationDocumentsDirectory();

  final db = await getDatabase(path.join(appDocDir.path, databaseName));

  final repository = SqliteTaskRepository(db);
  final repositoryConfigs = SqliteConfigsRepository(db);

  final taskController = TodoTaskController(repository);
  final configsController = TodoConfigsController(repositoryConfigs);

  await configsController.init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => taskController,
    ),
    ChangeNotifierProvider(
      create: (context) => configsController,
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    final isDark = Provider.of<TodoConfigsController>(context).darkMode;

    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessenger,
      debugShowCheckedModeBanner: false,
      title: 'Master Focus Todo',
      theme: lightTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: isDark ? dartTheme : lightTheme,
      initialRoute: SplashScreen.routeName,
      routes: routes,
      onGenerateRoute: onGenerateRoute,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pt', 'BR'),
      ],
    );
  }
}
