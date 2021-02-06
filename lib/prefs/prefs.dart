part of katana;

/// Save and load data locally.
///
/// After initializing and initializing the data, get and save the data.
///
/// ```
/// await Prefs.init();
/// String data = Prefs.get("key");
/// Prefs.set( "test", "data" );
/// ```
class Prefs {
  Prefs._();

  /// True if the data has been initialized.
  static bool get isInitialized => _preferences != null;
  static SharedPreferences? _preferences;

  /// Initialize the data.
  static Future initialize() async {
    if (isInitialized) {
      return;
    }
    _preferences = await SharedPreferences.getInstance();
  }

  /// Update data.
  static Future reload() async {
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    await _preferences?.reload();
  }

  /// Get the data.
  ///
  /// [key]: Key to get.
  /// [defaultValue]: Default value when there is no data.
  static T? get<T>(String key, [T? defaultValue]) {
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    if (!containsKey(key)) {
      return defaultValue;
    }
    return _preferences?.get(key) as T ?? defaultValue;
  }

  /// Get the data.
  ///
  /// [key]: Key to get.
  /// [defaultValue]: Default value when there is no data.
  static String getString(String key, [String defaultValue = ""]) {
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    if (!containsKey(key)) {
      return defaultValue;
    }
    return _preferences?.getString(key) ?? defaultValue;
  }

  /// Get the data.
  ///
  /// [key]: Key to get.
  /// [defaultValue]: Default value when there is no data.
  static List<String> getStringList(String key,
      [List<String> defaultValue = const []]) {
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    if (!containsKey(key)) {
      return defaultValue;
    }
    return _preferences?.getStringList(key) ?? defaultValue;
  }

  /// Get the data.
  ///
  /// [key]: Key to get.
  /// [defaultValue]: Default value when there is no data.
  static int getInt(String key, [int defaultValue = 0]) {
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    if (!containsKey(key)) {
      return defaultValue;
    }
    return _preferences?.getInt(key) ?? defaultValue;
  }

  /// Get the data.
  ///
  /// [key]: Key to get.
  /// [defaultValue]: Default value when there is no data.
  static double getDouble(String key, [double defaultValue = 0.0]) {
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    if (!containsKey(key)) {
      return defaultValue;
    }
    return _preferences?.getDouble(key) ?? defaultValue;
  }

  /// Get the data.
  ///
  /// [key]: Key to get.
  /// [defaultValue]: Default value when there is no data.
  static bool getBool(String key, [bool defaultValue = false]) {
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    if (!containsKey(key)) {
      return defaultValue;
    }
    return _preferences?.getBool(key) ?? defaultValue;
  }

  /// Get all stored keys.
  static Set<String> get keys {
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    return _preferences?.getKeys() ?? const {};
  }

  /// Check if data exists.
  ///
  /// True if data exists.
  ///
  /// [key]: Key to check.
  static bool containsKey(String key) {
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    return _preferences?.containsKey(key) ?? false;
  }

  /// Save the data.
  ///
  /// [key]: Key to save.
  /// [value]: Value to save.
  static void set(String key, dynamic value) {
    assert(value != null, "The value is empty.");
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    switch (value.runtimeType) {
      case int:
        _preferences?.setInt(key, value);
        break;
      case double:
        _preferences?.setDouble(key, value);
        break;
      case String:
        _preferences?.setString(key, value);
        break;
      case bool:
        _preferences?.setBool(key, value);
        break;
      case List:
        _preferences?.setStringList(key, value);
        break;
    }
  }

  /// Delete [key] from data.
  ///
  /// [key]: Key to delete.
  static void remove(String key) {
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    _preferences?.remove(key);
  }

  /// Initialize the data.
  static void clear() {
    assert(isInitialized,
        "It has not been initialized. Please initialize it by executing [init()].");
    _preferences?.clear();
  }
}
