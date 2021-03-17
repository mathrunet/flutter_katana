part of katana;

/// Class that handles the app config.
///
/// It is possible to determine the platform
/// and get the directory path synchronously.
///
/// Execute [initialize()] when the application starts.
///
/// ```
/// await Config.initialize();
/// ```
///
/// You can check whether it is initialized or not by [isInitialized].
class Config {
  Config._();

  /// True if the config has been initialized.
  static bool get isInitialized => _isInitialized;
  static bool _isInitialized = false;
  static final String _uidKey = "DeviceUniqueIdentifier".toSHA1();
  static late String _uid;
  static late String _flavor;
  static late bool _isMockup;

  /// Initialize the configuration.
  ///
  /// Runs the first time the app is run.
  static Future<void> initialize({
    required String flavor,
    bool enableMockup = false,
  }) async {
    if (isInitialized) {
      return;
    }
    _flavor = flavor;
    _isMockup = enableMockup;
    await Prefs.initialize();
    if (!Prefs.containsKey(_uidKey)) {
      Prefs.set(_uidKey, _uid = uuid);
    } else {
      _uid = Prefs.getString(_uidKey);
    }
    _isInitialized = true;
  }

  /// Callback called when the user's state is changed.
  static final UserStateChangedCallback onUserStateChanged =
      UserStateChangedCallback._();

  /// True if it is web.
  static bool get isWeb => kIsWeb;

  /// True if it is debug mode.
  static bool get isDebug => kDebugMode;

  /// True if it is release mode.
  static bool get isRelease => kReleaseMode;

  /// True for Android apps.
  static bool get isAndroid => !isWeb && Platform.isAndroid;

  /// True for IOS apps.
  static bool get isIOS => !isWeb && Platform.isIOS;

  /// Get the UniqueID of the device.
  static String get uid => _uid;

  /// Get the flavor of the app.
  static String get flavor => _flavor;

  /// True if mockup is enabled.
  ///
  /// If this is enabled, it will force a mockup to be displayed.
  static bool get isMockup => _isMockup;

  /// Check the connection status.
  ///
  /// You can specify the callback when connected with [onConnected] and
  /// when disconnected with [onDisconnected].
  static Future<ConnectivityResult> connect(
      {VoidCallback? onConnected, VoidCallback? onDisconnected}) async {
    final result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      onDisconnected?.call();
    } else {
      onConnected?.call();
    }
    return result;
  }
}

/// Callback class to be called when the user's state is changed.
class UserStateChangedCallback {
  UserStateChangedCallback._();
  final List<FutureOr<void> Function(String userId)> _callbacks = [];

  /// Registers a [callback] to be executed when the user's status is changed.
  void addListener(FutureOr<void> Function(String userId) callback) {
    if (_callbacks.contains(callback)) {
      return;
    }
    _callbacks.add(callback);
  }

  /// Removes a [callback] that has already been registered.
  void removeListener(FutureOr<void> Function(String userId) callback) {
    _callbacks.remove(callback);
  }

  /// Invokes a registered callback. [userId] is required.
  Future<void> call(String userId) {
    return Future.wait(
      _callbacks
          .mapAndRemoveEmpty((element) async => await element.call(userId)),
    );
  }
}
