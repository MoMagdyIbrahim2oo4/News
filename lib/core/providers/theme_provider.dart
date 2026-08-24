import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider مسؤول عن إدارة الثيم في التطبيق
class ThemeProvider extends ChangeNotifier {
  // الثيم الافتراضي عند تشغيل التطبيق لأول مرة
  ThemeMode _themeMode = ThemeMode.system;

  // Getter لمعرفة هل الثيم الحالي Dark
  bool get isDark => _themeMode == ThemeMode.dark;

  // المفتاح اللي هنخزن بيه قيمة الثيم في SharedPreferences
  static const String _key = "theme_mode";

  // Getter علشان أي Widget تقدر تعرف الثيم الحالي
  ThemeMode get themeMode => _themeMode;

  // Constructor
  // أول ما يتعمل ThemeProvider هيقرأ الثيم المحفوظ
  ThemeProvider() {
    _loadTheme();
  }

  // قراءة الثيم من SharedPreferences
  Future<void> _loadTheme() async {
    // افتح SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // اقرأ القيمة المحفوظة
    // هترجع 0 أو 1 أو 2
    final savedIndex = prefs.getInt(_key);

    // لو فيه قيمة متخزنة
    if (savedIndex != null) {
      // ThemeMode.values عبارة عن List:
      // [
      //   ThemeMode.system, // index = 0
      //   ThemeMode.light,  // index = 1
      //   ThemeMode.dark    // index = 2
      // ]

      // لو savedIndex = 2
      // يبقى ThemeMode.values[2]
      // = ThemeMode.dark
      _themeMode = ThemeMode.values[savedIndex];

      // بلغ كل الـ Widgets إن الثيم اتغير
      notifyListeners();
    }
  }

  // تغيير الثيم
  void setThemeMode(ThemeMode mode) async {
    // غير قيمة الثيم
    _themeMode = mode;

    // حدث واجهة التطبيق
    notifyListeners();

    // افتح SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // خزّن الـ index
    // system = 0
    // light = 1
    // dark = 2
    await prefs.setInt(_key, mode.index);
  }
}