// Copyright 2021 mathru. All rights reserved.

/// This package contains utility classes such as the Masamune package.
///
/// To use, import `package:katana/katana.dart`.
///
/// [mathru.net]: https://mathru.net
/// [YouTube]: https://www.youtube.com/c/mathrunetchannel
library katana;

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'config/others/others.dart'
    if (dart.library.io) 'config/mobile/mobile.dart'
    if (dart.library.js) 'config/others/others.dart'
    if (dart.library.html) 'config/others/others.dart';

export 'package:sprintf/sprintf.dart';
export 'config/others/others.dart'
    if (dart.library.io) 'config/mobile/mobile.dart'
    if (dart.library.js) 'config/others/others.dart'
    if (dart.library.html) 'config/others/others.dart';

part "localize/localize.dart";
part "prefs/prefs.dart";
part "src/const.dart";
part "src/extensions.dart";
part "src/functions.dart";
part "src/typedef.dart";
