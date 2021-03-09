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
///
/// [length]: Cord length.
/// [seed]: Seed number.
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

/// Open a new external URL.
///
/// [url]: URL to open.
Future<void> openURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print("Could not Launch $url");
  }
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
