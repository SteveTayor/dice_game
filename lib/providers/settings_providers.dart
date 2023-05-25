import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    if (isOn && themeMode != ThemeMode.dark) {
      themeMode = ThemeMode.dark;
      notifyListeners();
    } else if (!isOn && themeMode != ThemeMode.light) {
      themeMode = ThemeMode.light;
      notifyListeners();
    }
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.dark(),
    useMaterial3: true,
    iconTheme: IconThemeData(
      color: Colors.white,
      opacity: 0.8,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.deepPurple,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
    ),
    useMaterial3: true,
    iconTheme: const IconThemeData(
      color: Colors.red,
      opacity: 0.8,
    ),
  );
}
