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
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';

part "src/extensions.dart";
part "src/functions.dart";

part "localize/localize.dart";

part "prefs/prefs.dart";

part "config/config.dart";
