import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/login_response.dart';

SharedPreferences? _sharedPreferences;

class SharedPreferenceHelper {
  static const String _USER = 'SharedPreferenceHelper.user';
  static const String _IS_ENGLISH = 'SharedPreferenceHelper.isEnglish';
  static const String _IS_THEME = 'SharedPreferenceHelper.isTheme';

  static SharedPreferenceHelper? _instance;

  SharedPreferenceHelper._();

  static SharedPreferenceHelper instance() {
    _instance ??= SharedPreferenceHelper._();
    return _instance!;
  }

  static Future<void> initializeSharedPreferences() async => _sharedPreferences = await SharedPreferences.getInstance();

  set isEnglish(bool value) => _sharedPreferences?.setBool(_IS_ENGLISH, value);

  set isTheme(bool value) => _sharedPreferences?.setBool(_IS_THEME, value);

  bool get isEnglish => _sharedPreferences?.getBool(_IS_ENGLISH) ?? true;

  bool get isTheme => _sharedPreferences?.getBool(_IS_THEME) ?? true;

  bool get isUserLoggedIn => _sharedPreferences?.containsKey(_USER) ?? false;

  Future<LoginResponse?> get user async {
    final userSerialization = _sharedPreferences?.getString(_USER);
    if (userSerialization == null) return null;
    try {
      return LoginResponse.fromJson(json.decode(userSerialization));
    } catch (_) {
      return null;
    }
  }

  Future<void> insertUser(LoginResponse response) async {
    final userSerialization = json.encode(response.toJson());
    _sharedPreferences?.setString(_USER, userSerialization);
  }

  Future<void> clear() async => _sharedPreferences?.clear();
}
