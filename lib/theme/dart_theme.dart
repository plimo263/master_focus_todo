import 'package:flutter/material.dart';
import 'package:master_focus_todo/theme/appbar_theme.dart';
import 'package:master_focus_todo/theme/buttons_theme.dart';
import 'package:master_focus_todo/theme/colors_theme.dart';

final dartTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: false,
  primarySwatch: primaryColor,
  elevatedButtonTheme: elevatedButtonTheme,
  outlinedButtonTheme: outlinedButtonTheme,
  appBarTheme: appbarTheme,
);
