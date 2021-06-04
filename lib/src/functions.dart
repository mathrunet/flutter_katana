part of katana;

/// Get UUID.
///
/// A 32-byte string without hyphens is output.
String get uuid {
  const uuid = Uuid();
  return uuid.v4().replaceAll("-", "");
}

/// Create a code of length [length] randomly for id.
///
/// Characters that are difficult to understand are omitted.
///
/// [seed] can be specified.
String generateCode(int length,
    {int seed = 0, String charSet = "23456789abcdefghjkmnpqrstuvwxy"}) {
  final _length = charSet.length;
  final rand = seed != 0 ? Random(seed) : Random();
  final codeUnits = List.generate(
    length,
    (index) {
      final n = rand.nextInt(_length);
      return charSet.codeUnitAt(n);
    },
  );
  return String.fromCharCodes(codeUnits);
}

/// Open a new external [url].
Future<void> openURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print("Could not Launch $url");
  }
}

/// [json] decoding.
///
/// Only maps are output. If it is not a map, null is output.
///
/// If Json cannot be converted, [defaultValue] will be returned.
Map<String, T> jsonDecodeAsMap<T extends Object>(String json,
    [Map<String, T> defaultValue = const {}]) {
  try {
    return (jsonDecode(json) as DynamicMap).cast<String, T>();
    // ignore: empty_catches
  } catch (e) {}
  return defaultValue;
}

/// [json] decoding.
///
/// Only lists are output. If it is not a list, null is output.
///
/// If Json cannot be converted, [defaultValue] will be returned.
List<T> jsonDecodeAsList<T extends Object>(String json,
    [List<T> defaultValue = const []]) {
  try {
    return (jsonDecode(json) as List).cast<T>();
    // ignore: empty_catches
  } catch (e) {}
  return defaultValue;
}
