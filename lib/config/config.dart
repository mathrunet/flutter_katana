part of katana;

/// Class that manages the configuration of Masamune framework.
///
/// Initial values are set but can be changed at any time.
class Config {
  Config._();

  /// True if the config has been initialized.
  static bool get isInitialized => _isInitialized;
  static bool _isInitialized = false;
  static final String _uidKey = "DeviceUniqueIdentifier".toSHA1();
  static late String _uid;
  static late Directory _temporaryDirectory;
  static late Directory _libraryDirectory;
  static late Directory _documentDirectory;

  /// Initialize the configuration.
  static Future<void> initialize() async {
    if (isInitialized) {
      return;
    }
    await Prefs.initialize();
    if (!Prefs.containsKey(_uidKey)) {
      Prefs.set(_uidKey, _uid = uuid);
    } else {
      _uid = Prefs.getString(_uidKey);
    }
    if (!isWeb) {
      _temporaryDirectory = (await getTemporaryDirectory())!;
      _documentDirectory = (await getApplicationDocumentsDirectory())!;
      _libraryDirectory = (isAndroid
          ? await getExternalStorageDirectory()
          : await getLibraryDirectory())!;
    }
    _isInitialized = true;
  }

  /// True if it is web.
  static bool get isWeb => kIsWeb;

  /// True for Android apps.
  static bool get isAndroid => !isWeb && Platform.isAndroid;

  /// True for IOS apps.
  static bool get isIOS => !isWeb && Platform.isIOS;

  /// The directory that stores temporary files.
  static Directory get temporaryDirectory => _temporaryDirectory;

  /// The directory where you want to save the document file.
  static Directory get documentDirectory => _documentDirectory;

  /// The directory where you want to save the library file.
  static Directory get libraryDirectory => _libraryDirectory;

  /// Get the UniqueID of the device.
  static String get uid => _uid;

  /// Check the connection status.
  ///
  /// [onConnected]: Callbacks on connection.
  /// [onDisconnected]: Callbacks when you're not connected.
  // static Future<ConnectivityResult> connect(
  //     {VoidCallback? onConnected, VoidCallback? onDisconnected}) async {
  //   final result = await Connectivity().checkConnectivity();
  //   if (result == ConnectivityResult.none) {
  //     onDisconnected?.call();
  //   } else {
  //     onConnected?.call();
  //   }
  //   return result;
  // }
}
