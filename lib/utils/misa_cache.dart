import 'package:shared_preferences/shared_preferences.dart';

class MSCache {
  static MSCache _instance;
  static SharedPreferences _cache;

  MSCache._internal();

  Future _init() async {
    _cache = await SharedPreferences.getInstance();
  }

  static Future<MSCache> get shared async {
    return await getInstance();
  }

  static Future<MSCache> getInstance() async {
    if (_instance == null) {
      _instance = MSCache._internal();
      await _instance._init();
    }
    return _instance;
  }

  bool hasKey(String key) {
    Set keys = _cache.getKeys();
    return keys.contains(key);
  }

  Future<bool> putString(String key, String value) async {
    return _cache.setString(key, value);
  }

  Future<bool> removeKey(String key) async {
    return _cache.remove(key);
  }

  Future<bool> removeAllKey() async {
    return _cache.clear();
  }

  String getString(String key, {String valueDef}) {
    if (hasKey(key) == false) {
      return valueDef ?? null;
    }
    return _cache.getString(key);
  }

  Future<bool> putInt(String key, int value) async {
    return _cache.setInt(key, value);
  }

  int getInt(String key, {int valueDef}) {
    if (hasKey(key) == false) {
      return valueDef ?? -1;
    }
    return _cache.getInt(key);
  }

  Future<bool> putBoolean(String key, bool value) {
    return _cache.setBool(key, value);
  }

  bool getBoolean(String key, {bool valueDef}) {
    if (hasKey(key) == false) {
      return valueDef ?? false;
    }

    return _cache.getBool(key);
  }

  Future<bool> setDouble(String key, double value) {
    return _cache.setDouble(key, value);
  }

  double getDouble(String key, {double valueDef}) {
    if (hasKey(key) == false) {
      return valueDef ?? -1.0;
    }

    return _cache.getDouble(key);
  }
}
