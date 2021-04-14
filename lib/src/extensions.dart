part of katana;

extension StringExtensions on String {
  static final RegExp _tail = RegExp(r"[^/]+$");

  /// Measure the length of [path].
  ///
  /// By entering [separator], it can be used for purposes other than paths.
  int splitLength({String separator = "/"}) {
    if (isEmpty) {
      return 0;
    }
    final paths = split(separator);
    final length = paths.length;
    return length;
  }

  /// Get the path of the parent from the current string.
  ///
  /// By entering [separator], it can be used for purposes other than paths.
  String parentPath({String separator = "/"}) {
    if (isEmpty) {
      return this;
    }
    final path = trimString(separator);
    return path.replaceAll(_tail, "").trimStringRight(separator);
  }

  /// Splits the text by character.
  ///
  /// It is used for searching.
  List<String> splitByCharacter() {
    if (isEmpty) {
      return <String>[];
    }
    if (length <= 1) {
      return [this];
    }
    final tmp = <String>[];
    for (int i = 0; i < length - 1; i++) {
      tmp.add(substring(i, min(i + 1, length)));
    }
    return tmp;
  }

  /// Splits the text using the bigram algorithm.
  ///
  /// It is used for searching.
  List<String> splitByBigram() {
    if (isEmpty) {
      return <String>[];
    }
    if (length <= 2) {
      return [this];
    }
    final tmp = <String>[];
    for (int i = 0; i < length - 1; i++) {
      tmp.add(substring(i, min(i + 2, length)));
    }
    return tmp;
  }

  /// Splits the text using the trigram algorithm.
  ///
  /// It is used for searching.
  List<String> splitByTrigram() {
    if (isEmpty) {
      return [];
    }
    if (length <= 3) {
      return [this];
    }
    final tmp = <String>[];
    for (int i = 0; i < length - 2; i++) {
      tmp.add(substring(i, min(i + 3, length)));
    }
    return tmp;
  }

  /// Trim with specific characters.
  ///
  /// Specify the character string to be trimmed in [chars].
  String trimString(String chars) {
    final pattern = chars.isNotEmpty
        ? RegExp("^[$chars]+|[$chars]+\$")
        : RegExp(r"^\s+|\s+$");
    return replaceAll(pattern, "");
  }

  /// Trim only the left side with a specific string.
  ///
  /// Specify the character string to be trimmed in [chars].
  String trimStringLeft(String chars) {
    final pattern = chars.isNotEmpty ? RegExp("^[$chars]+") : RegExp(r"^\s+");
    return replaceAll(pattern, "");
  }

  /// Trim only the right side with a specific string.
  ///
  /// Specify the character string to be trimmed in [chars].
  String trimStringRight(String chars) {
    final pattern = chars.isNotEmpty ? RegExp("[$chars]+\$") : RegExp(r"\s+$");
    return replaceAll(pattern, "");
  }

  /// Converts a String to an int.
  ///
  /// Normally it parses, but if it cannot parse it, it creates a random string.
  int toInt() {
    if (isEmpty) {
      return 0;
    }
    final i = int.tryParse(this);
    if (i != null) {
      return i;
    }
    int val = 0;
    for (final rune in runes) {
      val += (val + 1) * rune;
    }
    return val;
  }

  /// Converts a String to an int.
  ///
  /// Normally it parses, but if it cannot parse it, it creates a random string.
  double toDouble() {
    if (isEmpty) {
      return 0.0;
    }
    final d = double.tryParse(this);
    if (d != null) {
      return d;
    }
    double val = 0.0;
    for (final rune in runes) {
      val += (val + 1.0) * rune;
    }
    return val;
  }

  /// Parses a String into a bool.
  bool toBool() {
    if (toLowerCase() == "true") {
      return true;
    }
    return false;
  }

  /// Encoded in Base64.
  String toBase64() => utf8.fuse(base64).encode(this);

  /// Decoded in Base64.
  String fromBase64() => utf8.fuse(base64).decode(this);

  /// Convert to SHA1 hash.
  String toSHA1() => sha1.convert(utf8.encode(this)).toString();

  /// Convert to SHA256 hash.
  ///
  /// Set the password for encoding to [password].
  String toSHA256(String password) {
    final hmacSha256 = Hmac(sha256, utf8.encode(password));
    return hmacSha256.convert(utf8.encode(this)).toString();
  }

  /// Get translated text.
  String localize() => Localize.get(this, defaultValue: this);
}

extension NullableObjectExtensions on Object? {
  /// Specifies the initial value when the value is [Null].
  ///
  /// If the value is [Null],
  /// the value specified by [defaultValue] will be returned.
  ///
  /// All returned values will be of type non-null.
  T def<T>(T defaultValue) {
    if (this == null) {
      return defaultValue;
    }
    return this as T;
  }
}

extension NullableStringExtensions on String? {
  /// Whether this string is empty.
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  /// Whether this string is not empty
  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }

  /// The length of the string.
  ///
  /// Returns the number of UTF-16 code units in this string.
  /// The number of runes might be fewer,
  /// if the string contains characters outside the Basic Multilingual Plane (plane 0):
  ///
  /// 'Dart'.length;          // 4
  /// 'Dart'.runes.length;    // 4
  ///
  /// var clef = '\u{1D11E}';
  /// clef.length;            // 2
  /// clef.runes.length;      // 1
  int get length {
    if (this == null) {
      return 0;
    }
    return this!.length;
  }

  /// Get translated text.
  String localize(String defaultValue) {
    if (this == null) {
      return defaultValue;
    }
    return Localize.get(this!, defaultValue: this!);
  }
}

extension NullableIterableExtensions<T> on Iterable<T>? {
  /// Returns true if there are no elements in this collection.
  ///
  /// May be computed by checking if iterator.moveNext() returns false.
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  /// Returns true if there is at least one element in this collection.
  ///
  /// May be computed by checking if iterator.moveNext() returns true.
  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }

  /// Returns the number of elements in [this].
  ///
  /// Counting all elements may involve iterating through all elements and can therefore be slow.
  /// Some iterables have a more efficient way to find the number of elements.
  int get length {
    if (this == null) {
      return 0;
    }
    return this!.length;
  }

  /// Returns the first element.
  ///
  /// Return `null` if the list has no element.
  T? get firstOrNull {
    if (this == null || isEmpty) {
      return null;
    }
    return this?.first;
  }

  /// Returns the last element.
  ///
  /// Return `null` if the list has no element.
  T? get lastOrNull {
    if (this == null || isEmpty) {
      return null;
    }
    return this?.last;
  }

  /// Returns the first value found by searching based on the condition specified in [test].
  ///
  /// If the value is not found, [Null] is returned.
  T? firstWhereOrNull(bool Function(T item) test) {
    if (this == null || isEmpty) {
      return null;
    }
    for (final element in this!) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  /// Whether the collection contains an element equal to [element].
  ///
  /// This operation will check each element in order for being equal to [element],
  /// unless it has a more efficient way to find an element equal to [element].
  ///
  /// The equality used to determine whether [element] is equal to an element of the iterable defaults to the [Object.==] of the element.
  ///
  /// Some types of iterable may have a different equality used for its elements.
  /// For example, a [Set] may have a custom equality (see [Set.identity]) that its contains uses.
  /// Likewise the Iterable returned by a [Map.keys] call should use the same equality that the Map uses for keys.
  bool contains(Object? element) {
    if (this == null) {
      return false;
    }
    return this!.contains(element);
  }

  /// Returns `true` if any of the given [elements] is in the list.
  bool containsAny(Iterable<Object?> elements) {
    if (this == null) {
      return false;
    }
    return elements.any((element) => this!.contains(element));
  }

  /// Returns `true` if all of the given [elements] is in the list.
  bool containsAll(Iterable<Object?> elements) {
    if (this == null) {
      return false;
    }
    return elements.every((element) => this!.contains(element));
  }
}

extension MapExtensions<K, V> on Map<K, V> {
  /// Convert it to a list through [callback].
  Iterable<T> toList<T>(T Function(K key, V value) callback) sync* {
    for (final tmp in entries) {
      yield callback(tmp.key, tmp.value);
    }
  }

  /// Set only the value of the key specified
  /// by [keys] in the map specified by [other].
  ///
  /// ```
  /// final main = {"c": 3, "d": 4};
  /// final other = {"a": 1, "b": 2};
  /// main.addWith(other, ["a"]);     // {"a": 1, "c": 3, "d": 4}
  /// ```
  Map<K, V> addWith(Map<K, V> other, Iterable<K> keys) {
    for (final key in keys) {
      if (!other.containsKey(key)) {
        continue;
      }
      // ignore: null_check_on_nullable_type_parameter
      this[key] = other[key]!;
    }
    return this;
  }

  /// Get the value corresponding to [key] in the map.
  ///
  /// If [key] is not found, the value of [orElse] is returned.
  T get<T>(K key, T orElse) {
    assert(key != null, "The key is empty.");
    if (!containsKey(key)) {
      return orElse;
    }
    return (this[key] ?? orElse) as T;
  }

  /// Merges the map in [others] with the current map.
  ///
  /// If the same key is found, the value of [others] has priority.
  Map<K, V> merge(Map<K, V>? others) {
    others ??= const {};
    final res = <K, V>{};
    for (final tmp in entries) {
      res[tmp.key] = tmp.value;
    }
    for (final tmp in others.entries) {
      res[tmp.key] = tmp.value;
    }
    return res;
  }

  /// Returns `true` if any of the given [keys] is in the map.
  bool containsKeyAny(Iterable<Object?> keys) {
    return keys.any((element) => containsKey(element));
  }

  /// Returns `true` if all of the given [keys] is in the map.
  bool containsKeyAll(Iterable<Object?> keys) {
    return keys.every((element) => containsKey(element));
  }

  /// Returns `true` if any of the given [values] is in the map.
  bool containsValueAny(Iterable<Object?> values) {
    return values.any((element) => containsValue(element));
  }

  /// Returns `true` if all of the given [values] is in the map.
  bool containsValueAll(Iterable<Object?> values) {
    return values.every((element) => containsValue(element));
  }
}

extension NullableMapExtensions<K, V> on Map<K, V>? {
  /// Whether there is no key/value pair in the map.
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  /// Whether there is at least one key/value pair in the map.
  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }

  /// The number of key/value pairs in the map.
  int get length {
    if (this == null) {
      return 0;
    }
    return this!.length;
  }

  /// Whether this map contains the given key.
  ///
  /// Returns true if any of the keys in the map are equal to key according to the equality used by the map.
  bool containsKey(Object? element) {
    if (this == null) {
      return false;
    }
    return this!.containsKey(element);
  }

  /// Whether this map contains the given value.
  ///
  /// Returns true if any of the values in the map are equal to value according to the == operator.
  bool containsValue(Object? element) {
    if (this == null) {
      return false;
    }
    return this!.containsValue(element);
  }

  /// Get the value corresponding to [key] in the map.
  ///
  /// If [key] is not found, the value of [orElse] is returned.
  T get<T>(K key, T orElse) {
    assert(key != null, "The key is empty.");
    if (this == null || !containsKey(key)) {
      return orElse;
    }
    return (this![key] ?? orElse) as T;
  }

  /// Merges the map in [others] with the current map.
  ///
  /// If the same key is found, the value of [others] has priority.
  Map<K, V> merge(Map<K, V>? others) {
    others ??= const {};
    final res = <K, V>{};
    if (this != null) {
      for (final tmp in this!.entries) {
        res[tmp.key] = tmp.value;
      }
    }
    for (final tmp in others.entries) {
      res[tmp.key] = tmp.value;
    }
    return res;
  }

  /// Returns `true` if any of the given [keys] is in the map.
  bool containsKeyAny(Iterable<Object?> keys) {
    if (this == null) {
      return false;
    }
    return keys.any((element) => this!.containsKey(element));
  }

  /// Returns `true` if all of the given [keys] is in the map.
  bool containsKeyAll(Iterable<Object?> keys) {
    if (this == null) {
      return false;
    }
    return keys.every((element) => this!.containsKey(element));
  }

  /// Returns `true` if any of the given [values] is in the map.
  bool containsValueAny(Iterable<Object?> values) {
    if (this == null) {
      return false;
    }
    return values.any((element) => this!.containsValue(element));
  }

  /// Returns `true` if all of the given [values] is in the map.
  bool containsValueAll(Iterable<Object?> values) {
    if (this == null) {
      return false;
    }
    return values.every((element) => this!.containsValue(element));
  }
}

extension SetExtensions<T> on Set<T> {
  /// Returns `true` if any of the given [others] is in the list.
  bool containsAny(Iterable<Object?> others) {
    return others.any((element) => contains(element));
  }
}

extension NullableSetExtensions<T> on Set<T>? {
  /// Returns true if there are no elements in this collection.
  ///
  /// May be computed by checking if iterator.moveNext() returns false.
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  /// Returns true if there is at least one element in this collection.
  ///
  /// May be computed by checking if iterator.moveNext() returns true.
  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }

  /// Returns the number of elements in the iterable.
  ///
  /// This is an efficient operation that doesn't require iterating through the elements.
  int get length {
    if (this == null) {
      return 0;
    }
    return this!.length;
  }

  /// Whether value is in the set.
  bool contains(Object? element) {
    if (this == null) {
      return false;
    }
    return this!.contains(element);
  }

  /// Returns `true` if any of the given [others] is in the list.
  bool containsAny(Iterable<Object?> others) {
    if (this == null) {
      return false;
    }
    return others.any((element) => this!.contains(element));
  }
}

extension NullableIntExtensions on int? {
  /// Whether this int is null or zero.
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this == 0;
  }

  /// Whether this int is not null or zero.
  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this != 0;
  }
}

extension NullableDoubleExtensions on double? {
  /// Whether this double is null or zero.
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this == 0.0;
  }

  /// Whether this double is not null or zero.
  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this != 0.0;
  }
}

extension IntExtensions on int {
  /// Whether this int is zero.
  bool get isEmpty => this == 0;

  /// Whether this int is not zero.
  bool get isNotEmpty => this != 0;

  /// Restrict value from [min] to [max].
  int limit(int min, int max) {
    if (this < min) {
      return min;
    }
    if (this > max) {
      return max;
    }
    return this;
  }

  /// Restrict value from [min].
  int limitLow(int min) {
    if (this < min) {
      return min;
    }
    return this;
  }

  /// Restrict value from [max].
  int limitHigh(int max) {
    if (this > max) {
      return max;
    }
    return this;
  }

  /// Represents a number in [format].
  ///
  /// The [format] depends on NumberFormat.
  String format(String format) {
    assert(format.isNotEmpty, "The format is empty.");
    return NumberFormat(format).format(this);
  }
}

extension DoubleExtensions on double {
  /// Whether this int is zero.
  bool get isEmpty => this == 0.0;

  /// Whether this int is not zero.
  bool get isNotEmpty => this != 0.0;

  /// Restrict value from [min] to [max].
  double limit(double min, double max) {
    if (this < min) {
      return min;
    }
    if (this > max) {
      return max;
    }
    return this;
  }

  /// Restrict value from [min].
  double limitLow(double min) {
    if (this < min) {
      return min;
    }
    return this;
  }

  /// Restrict value from [max].
  double limitHigh(double max) {
    if (this > max) {
      return max;
    }
    return this;
  }

  /// Represents a number in [format].
  ///
  /// The [format] depends on NumberFormat.
  String format(String format) {
    assert(format.isNotEmpty, "The format is empty.");
    return NumberFormat(format).format(this);
  }
}

extension RandomExtension on Random {
  /// Get a random number from [min] to [max].
  int rangeInt(int min, int max) =>
      ((nextDouble() * (max - min)) + min).toInt().limit(min, max);

  /// Get a random number from [min] to [max].
  double rangeDouble(double min, double max) =>
      ((nextDouble() * (max - min)) + min).limit(min, max);
}

extension DurationExtension on Duration {
  /// Format and output the duration.
  ///
  /// Enter the format of the date and time in [format].
  String format(String format) {
    assert(format.isNotEmpty, "The format is empty.");
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return format
        .replaceAll("dd", inDays.toString())
        .replaceAll("HH", twoDigits(inHours))
        .replaceAll("mm", twoDigits(inMinutes.remainder(60)))
        .replaceAll("ss", twoDigits(inSeconds.remainder(60)));
  }
}

extension DateTimeExtension on DateTime {
  /// Gets the localized week.
  String get localizedWeekDay => "WeekDay${weekday.toString()}".localize();

  /// Gets the localized week.
  String get shortLocalizedWeekDay => "Week${weekday.toString()}".localize();

  /// True if the specified time or the current time is the same day.
  ///
  /// Pass the date and time you want to compare to [dateTime].
  /// If it is not passed, the current date and time is used.
  bool isToday([DateTime? dateTime]) {
    dateTime ??= DateTime.now();
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day;
  }

  /// True if the specified time or the current time is the same month.
  ///
  /// Pass the date and time you want to compare to [dateTime].
  /// If it is not passed, the current date and time is used.
  bool isThisMonth([DateTime? dateTime]) {
    dateTime ??= DateTime.now();
    return year == dateTime.year && month == dateTime.month;
  }

  /// True if the specified time or the current time is the same year.
  ///
  /// [dateTime]: Time to compare.
  bool isThisYear([DateTime? dateTime]) {
    dateTime ??= DateTime.now();
    return year == dateTime.year;
  }

  /// True if the specified time or the current time is the same hour.
  ///
  /// Pass the date and time you want to compare to [dateTime].
  /// If it is not passed, the current date and time is used.
  bool isThisHour([DateTime? dateTime]) {
    dateTime ??= DateTime.now();
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day &&
        hour == dateTime.hour;
  }

  /// True if the specified time or the current time is the same minute.
  ///
  /// [dateTime]: Time to compare.
  bool isThisMimute([DateTime? dateTime]) {
    dateTime ??= DateTime.now();
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day &&
        hour == dateTime.hour &&
        minute == dateTime.minute;
  }

  /// True if the specified time or the current time is the same second.
  ///
  /// Pass the date and time you want to compare to [dateTime].
  /// If it is not passed, the current date and time is used.
  bool isThisSecond([DateTime? dateTime]) {
    dateTime ??= DateTime.now();
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day &&
        hour == dateTime.hour &&
        minute == dateTime.minute &&
        second == dateTime.second;
  }

  /// Format and output the date.
  ///
  /// Enter the format of the date and time in [format].
  String format(String format) {
    assert(format.isNotEmpty, "The format is empty.");
    return DateFormat(format).format(this).replaceAll(
          "ww",
          weekNumber.toString().padLeft(2, "0"),
        );
  }

  /// Week number according to ISO 8601.
  int get weekNumber {
    final thursday = DateTime.fromMillisecondsSinceEpoch(
      ((millisecondsSinceEpoch - 259200000) / 604800000).ceil() * 604800000,
    );
    final firstDayOfYear = DateTime(thursday.year, 1, 1);
    return ((thursday.millisecondsSinceEpoch -
                    firstDayOfYear.millisecondsSinceEpoch) /
                604800000)
            .floor() +
        1;
  }
}

extension IterableExtensions<T> on Iterable<T> {
  /// Remove duplicate values from the list.
  List<T> distinct() => toSet().toList();

  /// Index and loop it through [callback].
  Iterable<T> index(T Function(T item, int index) callback) {
    int i = 0;
    for (final tmp in this) {
      callback(tmp, i);
      i++;
    }
    return this;
  }

  /// Returns the first element.
  ///
  /// Return `null` if the list has no element.
  T? get firstOrNull {
    if (isEmpty) {
      return null;
    }
    return first;
  }

  /// Returns the last element.
  ///
  /// Return `null` if the list has no element.
  T? get lastOrNull {
    if (isEmpty) {
      return null;
    }
    return last;
  }

  /// Returns the first value found by searching based on the condition specified in [test].
  ///
  /// If the value is not found, [Null] is returned.
  T? firstWhereOrNull(bool Function(T item) test) {
    if (isEmpty) {
      return null;
    }
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  /// After replacing the data in the list, delete the null.
  ///
  /// [callback]: Callback function used in map.
  List<TCast> mapAndRemoveEmpty<TCast>(TCast? Function(T item) callback) {
    return map<TCast?>(callback).removeEmpty();
  }

  /// After replacing the data in the list through [callback], delete the [Null].
  List<TCast> expandAndRemoveEmpty<TCast>(
      Iterable<TCast?> Function(T item) callback) {
    return expand<TCast?>(callback).removeEmpty();
  }

  /// Divides the array by the specified [length] into an array.
  Iterable<Iterable<T>> split(int length) {
    length = length.limit(0, this.length);
    List<T>? tmp;
    final res = <Iterable<T>>[];
    if (length == 0) {
      return res;
    }
    int i = 0;
    for (final item in this) {
      if (i % length == 0) {
        if (tmp != null) {
          res.add(tmp);
        }
        tmp = [];
      }
      tmp?.add(item);
      i++;
    }
    if (tmp != null) {
      res.add(tmp);
    }
    return res;
  }

  /// Creates a Map instance in which the keys and values are computed from the
  /// [iterable].
  ///
  /// For each element of the [iterable], a key/value pair is computed
  /// by applying [key] and [value] respectively to the element of the iterable.
  ///
  /// Equivalent to the map literal:
  /// ```dart
  /// <K, V>{for (var v in iterable) key(v): value(v)}
  /// ```
  /// The literal is generally preferable because it allows
  /// for a more precise typing.
  ///
  /// The example below creates a new map from a list of integers.
  /// The keys of `map` are the `list` values converted to strings,
  /// and the values of the `map` are the squares of the `list` values:
  /// ```dart
  /// List<int> list = [1, 2, 3];
  /// var map = Map<String, int>.fromIterable(list,
  ///     key: (item) => item.toString(),
  ///     value: (item) => item * item);
  /// // map is {"1": 1, "2": 4, "3": 9}
  /// ```
  /// If no values are specified for [key] and [value],
  /// the default is the identity function.
  /// In that case, the iterable element must be assignable to the
  /// key or value type of the created map.
  ///
  /// In the following example, the keys and corresponding values of `map`
  /// are the `list` values directly:
  /// ```dart
  /// var map = Map<int, int>.fromIterable(list);
  /// // map is {1: 1, 2: 2, 3: 3}
  /// ```
  /// The keys computed by the source [iterable] do not need to be unique.
  /// The last occurrence of a key will overwrite
  /// the value of any previous occurrence.
  ///
  /// The created map is a [LinkedHashMap].
  /// A `LinkedHashMap` requires the keys to implement compatible
  /// `operator==` and `hashCode`.
  /// It iterates in key insertion order.
  Map<K, V> toMap<K, V>({
    K Function(dynamic e)? key,
    V Function(dynamic e)? value,
  }) {
    return Map.fromIterable(this, key: key, value: value);
  }

  /// Extract an array with a given range between [start] and [end].
  List<T> limit(int start, int end) {
    if (this is List) {
      return (this as List).sublist(start, min(length, end + 1)).cast<T>();
    } else {
      return toList().sublist(start, min(length, end + 1));
    }
  }

  /// Extract an array with a given range at [start].
  List<T> limitStart(int start) => limit(start, length);

  /// Extract an array with a given range at [end].
  List<T> limitEnd(int end) => limit(0, end);

  /// Returns `true` if any of the given [elements] is in the list.
  bool containsAny(Iterable<Object?> elements) {
    return elements.any((element) => contains(element));
  }

  /// Returns `true` if all of the given [elements] is in the list.
  bool containsAll(Iterable<Object?> elements) {
    return elements.every((element) => contains(element));
  }
}

extension NullableValueIterableExtensions<T> on Iterable<T?> {
  /// If the iterator value is empty, delete the element.
  List<T> removeEmpty() {
    final list = <T>[];
    for (final tmp in this) {
      if (tmp == null) {
        continue;
      }
      list.add(tmp);
    }
    return list;
  }
}

/// List extension methods.
extension ListExtensions<T> on List<T> {
  /// Insert the [element] first.
  List<T> insertFirst(T element) {
    insert(0, element);
    return this;
  }

  /// Insert the [element] last.
  List<T> insertLast(T element) {
    add(element);
    return this;
  }

  /// Inserts an [insert] element at the element's position if True with a [test].
  List<T> insertWhere(
      T element, bool Function(T? prev, T? current, T? next) test) {
    for (int i = length - 1; i >= 0; i--) {
      if (!test(i <= 0 ? null : this[i - 1], this[i],
          i >= length - 1 ? null : this[i + 1])) {
        continue;
      }
      insert(i, element);
      return this;
    }
    insert(0, element);
    return this;
  }
}

extension ColorExtensions on Color {
  /// Makes the color darker.
  ///
  /// The higher the value(0.0 - 1.0), the darker the image becomes.
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  /// Makes the color lighter.
  ///
  /// The higher the value(0.0 - 1.0), the lighter the image becomes.
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}
