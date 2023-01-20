import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  static SharedPreferences? _sharedPreferences;
  _() {}
  // ignore: empty_constructor_bodies
  static void initialize() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
  }

  static void add(String key, String value) {
    _sharedPreferences?.setString(key, value);
  }

  static void remove(String key) {
    _sharedPreferences?.remove(key);
  }

  static String get(String key) {
    return _sharedPreferences?.getString(key) ?? "";
  }

  static bool containsKey(String key) {
    return _sharedPreferences?.containsKey(key) ?? false;
  }
}
