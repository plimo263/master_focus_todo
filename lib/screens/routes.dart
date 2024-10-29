import 'package:flutter/material.dart';
import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/screens/configs/configs_screen.dart';
import 'package:master_focus_todo/screens/focus_details_screen.dart';
import 'package:master_focus_todo/screens/focus_list_screen.dart';
import 'package:master_focus_todo/screens/focus_screen.dart';
import 'package:master_focus_todo/screens/form_task_screen.dart';
import 'package:master_focus_todo/screens/home_screen.dart';
import 'package:master_focus_todo/screens/login_screen.dart';
import 'package:master_focus_todo/screens/splash_screen.dart';
import 'package:master_focus_todo/screens/statistics/statistics_screen.dart';

final routes = <String, Widget Function(BuildContext)>{
  StatisticsScreen.routeName: (context) => const StatisticsScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  ConfigsScreen.routeName: (context) => const ConfigsScreen(),
  FocusListScreen.routeName: (context) => const FocusListScreen(),
};

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case FocusDetailsScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => FocusDetailsScreen(task: args as TodoTask));
    case FocusScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => FocusScreen(task: args as TodoTask));
    case FormTaskScreen.routeName:
      final TodoTask? task = args as TodoTask?;
      return MaterialPageRoute(
        builder: (context) => FormTaskScreen(
          task: task,
        ),
      );
    default:
      return MaterialPageRoute(builder: (context) => const ConfigsScreen());
  }
}
