import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bite_zone/themes/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
  ThemeMode _themeMode;

  ThemeProvider()
      : _themeData = orangeTheme,
        _themeMode = ThemeMode.system {
    _loadTheme();
  }

  ThemeData get themeData => _themeData;
  ThemeMode get themeMode => _themeMode;

  void setTheme(ThemeData themeData, ThemeMode themeMode) {
    _themeData = themeData;
    _themeMode = themeMode;
    _saveTheme();
    notifyListeners();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('theme') ?? 'orangeTheme';
    switch (themeName) {
      case 'orangeTheme':
        _themeData = orangeTheme;
        break;
      case 'greenTheme':
        _themeData = greenTheme;
        break;
      case 'ashTheme':
        _themeData = darkAshTheme;
        break;
      case 'purpleTheme':
        _themeData = purpleTheme;
        break;
      case 'yellowTheme':
        _themeData = yellowTheme;
        break;
      default:
        _themeData = orangeTheme;
        break;
    }
    notifyListeners();
  }

  void _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String themeName;
    if (_themeData == orangeTheme) {
      themeName = 'orangeTheme';
    } else if (_themeData == greenTheme) {
      themeName = 'greenTheme';
    } else if (_themeData == darkAshTheme) {
      themeName = 'ashTheme';
    } else if (_themeData == purpleTheme) {
      themeName = 'purpleTheme';
    } else if (_themeData == yellowTheme) {
      themeName = 'yellowTheme';
    } else {
      themeName = 'orangeTheme';
    }
    await prefs.setString('theme', themeName);
  }
}
