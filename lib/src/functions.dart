part of katana;

/// Get UUID.
///
/// A 32-byte string without hyphens is output.
String get uuid {
  const uuid = Uuid();
  return uuid.v4().replaceAll("-", "");
}

/// Open a new external URL.
///
/// [url]: URL to open.
Future openURL(String url) async {
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
  //   print("Could not Launch $url");
  // }
}

/// Json decoding.
///
/// Only maps are output. If it is not a map, null is output.
///
/// [json]: Json string.
/// [defaultValue]: Default value.
Map<String, T> jsonDecodeAsMap<T extends Object>(String json,
    [Map<String, T> defaultValue = const {}]) {
  try {
    return (jsonDecode(json) as Map<String, dynamic>).cast<String, T>();
    // ignore: empty_catches
  } catch (e) {}
  return defaultValue;
}

/// Json decoding.
///
/// Only lists are output. If it is not a list, null is output.
///
/// [json]: Json string.
/// [defaultValue]: Default value.
List<T> jsonDecodeAsList<T extends Object>(String json,
    [List<T> defaultValue = const []]) {
  try {
    return (jsonDecode(json) as List).cast<T>();
    // ignore: empty_catches
  } catch (e) {}
  return defaultValue;
}
