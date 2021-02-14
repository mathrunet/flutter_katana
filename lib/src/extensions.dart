part of katana;

extension StringExtensions on String {
  static final RegExp _tail = RegExp(r"[^/]+$");

  /// Measure the length of [path].
  ///
  /// By entering [separator], it can be used for purposes other than paths.
  ///
  /// [separator]: Separator, default is [/].
  int splitLength({String separator = "/"}) {
    if (isEmpty) {
      return 0;
    }
    final paths = split(separator);
    final length = paths.length;
    return length;
  }

  String parentPath({String separator = "/"}) {
    if (isEmpty) {
      return this;
    }
    final path = trimString(separator);
    return path.replaceAll(_tail, "").trimStringRight(separator);
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
  /// [chars]: The string to trim.
  String trimString(String chars) {
    final pattern = chars.isNotEmpty
        ? RegExp("^[$chars]+|[$chars]+\$")
        : RegExp(r"^\s+|\s+$");
    return replaceAll(pattern, "");
  }

  /// Trim only the left side with a specific string.
  ///
  /// [chars]: The string to trim.
  String trimStringLeft(String chars) {
    final pattern = chars.isNotEmpty ? RegExp("^[$chars]+") : RegExp(r"^\s+");
    return replaceAll(pattern, "");
  }

  /// Trim only the right side with a specific string.
  ///
  /// [chars]: The string to trim.
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
  /// [password]: Password.
  String toSHA256(String password) {
    final hmacSha256 = Hmac(sha256, utf8.encode(password));
    return hmacSha256.convert(utf8.encode(this)).toString();
  }
}

extension NullableObjectExtensions on Object? {
  T def<T extends Object?>(T defaultValue) {
    if (this == null) {
      return defaultValue;
    }
    return this as T;
  }
}

extension NonNullableObjectExtensions on Object {
  T def<T extends Object>(T defaultValue) {
    return this as T;
  }
}

extension NullableStringExtensions on String? {
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }

  int get length {
    if (this == null) {
      return 0;
    }
    return this!.length;
  }
}

extension NullableIterableExtensions<T> on Iterable<T>? {
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }

  int get length {
    if (this == null) {
      return 0;
    }
    return this!.length;
  }

  bool contains(Object? element) {
    if (this == null) {
      return false;
    }
    return this!.contains(element);
  }
}

extension NullableMapExtensions<K, V> on Map<K, V>? {
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }

  int get length {
    if (this == null) {
      return 0;
    }
    return this!.length;
  }

  bool containsKey(Object? element) {
    if (this == null) {
      return false;
    }
    return this!.containsKey(element);
  }

  bool containsValue(Object? element) {
    if (this == null) {
      return false;
    }
    return this!.containsValue(element);
  }
}

extension NullableSetExtensions<T> on Set<T>? {
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }

  int get length {
    if (this == null) {
      return 0;
    }
    return this!.length;
  }

  bool contains(Object? element) {
    if (this == null) {
      return false;
    }
    return this!.contains(element);
  }
}

extension NullableIntExtensions on int? {
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }
}

extension NullableDoubleExtensions on double? {
  bool get isEmpty {
    if (this == null) {
      return true;
    }
    return this!.isEmpty;
  }

  bool get isNotEmpty {
    if (this == null) {
      return false;
    }
    return this!.isNotEmpty;
  }
}

extension MapStringDynamicExtensions on Map<String, dynamic> {
  T? get<T>(String key, [T? orElse]) {
    assert(key.isNotEmpty, "The key is empty.");
    if (!containsKey(key)) {
      return orElse;
    }
    return this[key] ?? orElse;
  }
}

extension MapExtensions<TKey, TValue> on Map<TKey, TValue> {
  /// Convert it to a list through [callback].
  ///
  /// [callback]: Callback function.
  Iterable<T> toList<T>(T Function(TKey key, TValue value) callback) sync* {
    for (final tmp in entries) {
      yield callback(tmp.key, tmp.value);
    }
  }
}

extension IntExtensions on int {
  bool get isEmpty => this == 0;

  bool get isNotEmpty => this != 0;

  /// Restrict value from [min] to [max].
  ///
  /// [min]: Minimum value.
  /// [max]: Maximum value.
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
  ///
  /// [min]: Minimum value.
  int limitLow(int min) {
    if (this < min) {
      return min;
    }
    return this;
  }

  /// Restrict value from [max].
  ///
  /// [max]: Maximum value.
  int limitHigh(int max) {
    if (this > max) {
      return max;
    }
    return this;
  }

  /// Represents a number in format.
  ///
  /// The format depends on NumberFormat.
  ///
  /// [format]: Number format.
  String format(String format) {
    assert(format.isNotEmpty, "The format is empty.");
    return NumberFormat(format).format(this);
  }
}

extension DoubleExtensions on double {
  bool get isEmpty => this == 0.0;

  bool get isNotEmpty => this != 0.0;

  /// Restrict value from [min] to [max].
  ///
  /// [min]: Minimum value.
  /// [max]: Maximum value.
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
  ///
  /// [min]: Minimum value.
  double limitLow(double min) {
    if (this < min) {
      return min;
    }
    return this;
  }

  /// Restrict value from [max].
  ///
  /// [max]: Maximum value.
  double limitHigh(double max) {
    if (this > max) {
      return max;
    }
    return this;
  }

  /// Represents a number in format.
  ///
  /// The format depends on NumberFormat.
  ///
  /// [format]: Number format.
  String format(String format) {
    assert(format.isNotEmpty, "The format is empty.");
    return NumberFormat(format).format(this);
  }
}

/// String extension methods.
extension LocalizeStringExtensions on String {
  /// Get translated text.
  String localize() => Localize.get(this, defaultValue: this);
}

/// DateTime extension methods.
extension LocalizeDateTimeExtensions on DateTime {
  /// Gets the localized week.
  String get localizedWeekDay => "WeekDay${weekday.toString()}".localize();

  /// Gets the localized week.
  String get shortLocalizedWeekDay => "Week${weekday.toString()}".localize();
}

/// Random extension methods.
extension RandomExtension on Random {
  /// Get a random number from [min] to [max].
  ///
  /// [min]: Minimum value.
  /// [max]: Maximum value.
  int rangeInt(int min, int max) =>
      ((nextDouble() * (max - min)) + min).toInt().limit(min, max);

  /// Get a random number from [min] to [max].
  ///
  /// [min]: Minimum value.
  /// [max]: Maximum value.
  double rangeDouble(double min, double max) =>
      ((nextDouble() * (max - min)) + min).limit(min, max);
}

/// DateTime extension methods.
extension DateTimeExtension on DateTime {
  /// True if the specified time or the current time is the same day.
  ///
  /// [dateTime]: Time to compare.
  bool isToday([DateTime? dateTime]) {
    dateTime ??= DateTime.now();
    return year == dateTime.year &&
        month == dateTime.month &&
        day == dateTime.day;
  }

  /// True if the specified time or the current time is the same month.
  ///
  /// [dateTime]: Time to compare.
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
  /// [dateTime]: Time to compare.
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
  /// [dateTime]: Time to compare.
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
  /// [format]: The format to specify.
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

/// Iterable extension methods.
extension IterableExtensions<T> on Iterable<T> {
  /// Remove duplicate values from the list.
  List<T> distinct() => toSet().toList();

  /// Index and loop it.
  ///
  /// [callback]: Callback function used in index.
  Iterable<T> index(T Function(T item, int index) callback) {
    int i = 0;
    for (final tmp in this) {
      callback(tmp, i);
      i++;
    }
    return this;
  }

  /// After replacing the data in the list, delete the null.
  ///
  /// [callback]: Callback function used in map.
  List<TCast> mapAndRemoveEmpty<TCast>(TCast? Function(T item) callback) {
    return map<TCast?>(callback).removeEmpty();
  }

  /// After replacing the data in the list, delete the null.
  ///
  /// [callback]: Callback function used in expand.
  List<TCast> expandAndRemoveEmpty<TCast>(
      Iterable<TCast?> Function(T item) callback) {
    return expand<TCast?>(callback).removeEmpty();
  }

  /// Divides the array by the specified number into an array.
  ///
  /// [length]: The number to divide.
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

  /// Converts the list into a map.
  ///
  /// [key]: Callback to get the key from the element.
  /// [value]: Callback to get the value from the element.
  Map<K, V> toMap<K, V>({
    K Function(dynamic e)? key,
    V Function(dynamic e)? value,
  }) {
    return Map.fromIterable(this, key: key, value: value);
  }

  /// Extract an array with a given range of numbers.
  ///
  /// [start]: Starting position.
  /// [end]: End position.
  List<T> limit(int start, int end) {
    if (this is List) {
      return (this as List).sublist(start, min(length, end + 1)).cast<T>();
    } else {
      return toList().sublist(start, min(length, end + 1));
    }
  }

  /// Extract an array with a given range of numbers.
  ///
  /// [start]: Starting position.
  List<T> limitStart(int start) => limit(start, length);

  /// Extract an array with a given range of numbers.
  ///
  /// [end]: End position.
  List<T> limitEnd(int end) => limit(0, end);
}

/// Iterable extension methods.
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
  /// Insert the element first.
  ///
  /// [element]: The element to insert.
  List<T> insertFirst(T element) {
    insert(0, element);
    return this;
  }

  /// Insert the element last.
  ///
  /// [element]: The element to insert.
  List<T> insertLast(T element) {
    add(element);
    return this;
  }

  /// Inserts an element at the element's position if True with a test.
  ///
  /// [insert]: The element to insert.
  /// [test]: The method to test.
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
