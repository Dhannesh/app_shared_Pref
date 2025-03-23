import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static late SharedPreferences _sharedPreferences;
  static PreferencesUtil? _currentInstance;
  PreferencesUtil._internal();

  factory PreferencesUtil() {
    _currentInstance = _currentInstance ?? PreferencesUtil._internal();
    return _currentInstance!;
  }
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setInt(String key, int value) async {
    return await _sharedPreferences.setInt(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _sharedPreferences.setString(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _sharedPreferences.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _sharedPreferences.setDouble(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    return await _sharedPreferences.setStringList(key, value);
  }

  int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }
  Set<String> getKeys() {
    return _sharedPreferences.getKeys();
  }
}
