import 'package:flutter/material.dart';
import 'package:bite_zone/themes/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = orangeTheme;

  ThemeData get themeData => _themeData;

  void setTheme(String role) {
    switch (role) {
      case 'USER':
        _themeData = orangeTheme;
        break;
      case 'SUPER_ADMIN':
        _themeData = greenTheme;
        break;
      default:
        _themeData = orangeTheme;
        break;
    }
    notifyListeners();
  }
}
