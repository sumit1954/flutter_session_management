import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:session_manager/session_manager.dart';

Future<void> main() async {
  SessionManager().setString("key", "value");

  String key = await SessionManager().getString("key");

  if (kDebugMode) {
    print("value of key $key");
  }
}
