import 'package:flutter/material.dart';
import 'package:flutter_temp_by_nqh/config/colors.dart';

class AppTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      backgroundColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,
      brightness: Brightness.light,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      backgroundColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.black,
      brightness: Brightness.dark,
    );
  }
}
