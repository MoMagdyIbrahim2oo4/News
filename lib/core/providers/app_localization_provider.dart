import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalizationProvider extends ChangeNotifier {
  Locale language = Locale("en");
  static const String _key = "app_localization";

  AppLocalizationProvider() {
    _loadLocalization();
  }

  Future<void> _loadLocalization() async {
    final prefs = await SharedPreferences.getInstance();
    String appLanguage = prefs.getString(_key) ?? "";
    language = Locale(appLanguage);
    notifyListeners();
  }

  Future<void> setLocalization(String locale) async {
    language = Locale(locale);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, locale);
  }

// void changeLanguage(String code) {
//   language = Locale(code);
//   notifyListeners();
// }
}