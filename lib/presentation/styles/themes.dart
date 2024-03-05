import 'package:flutter/material.dart';
import 'package:todelete2/presentation/styles/fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData theme = lightTheme;
  bool isDark = false;

  switchTheme() {
    theme = (theme == lightTheme ? darkTheme : lightTheme);
    isDark = (theme == lightTheme ? false : true);
    notifyListeners();
  }
}

final ThemeData lightTheme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light()
        .copyWith(background: Colors.white, primary: Ca.primary),);

final ThemeData darkTheme = ThemeData().copyWith(
    colorScheme: const ColorScheme.dark()
        .copyWith(background: Ca.prishade1, primary: Ca.primary),);
