library session_manager;

import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';

void printDebug(Object string, [String add = ""]) {
  if (kDebugMode) {
    print("$string $add");
  }
}

extension BoolStatus on bool {
  int get status => this ? 1 : 0;
}

bool getBoolType(int status) {
  return status == 1
      ? true
      : status == 0
          ? false
          : false;
}

class SessionManager {
  static const firebaseToken = "FirebaseToken";
  static const accessToken = "AccessToken";
  static const userDetails = "UserDetails";
  static const userId = "UserId";
  static const expiryDate = "ExpiryDate";

  SessionManager._internal();

  static final SessionManager sessionManager = SessionManager._internal();

  factory SessionManager() => sessionManager;

  ///FirebaseToken
  setFirebaseToken(String value) async {
    return await setString(firebaseToken, value);
  }

  Future<String> getFirebaseToken() async {
    return await getString(firebaseToken);
  }

  ///AccessToken
  setAccessToken(String value) async {
    return await setString(accessToken, value);
  }

  Future<String> getAccessToken() async {
    return await getString(accessToken);
  }

  ///UserDetails
  setUserDetails(String value) async {
    return await setString(userDetails, value);
  }

  Future<String> getUserDetails() async {
    return await getString(userDetails);
  }

  ///UserId
  setUserId(int value) async {
    return await setInt(userId, value);
  }

  Future<int?> getUserId() async {
    return await getInt(userId);
  }

  ///ExpiryDate
  setExpiryDate(DateTime value) async {
    return await setDate(expiryDate, value);
  }

  Future<DateTime?> getExpiryDate() async {
    return await getDate(expiryDate);
  }

  ///Date
  setDate(String key, DateTime value) async {
    setString(key, value.toIso8601String());
  }

  Future<DateTime?> getDate(String key) async {
    return DateTime.tryParse(await getString(key));
  }

  ///Boolean
  setBool(String key, bool value) async {
    setInt(key, value.status);
  }

  Future<bool> getBool(String key, {bool placeHolder = false}) async {
    try {
      return getBoolType(await getInt(key) ?? placeHolder.status);
    } catch (e) {
      printDebug(e);
      return placeHolder;
    }
  }

  ///Int
  setInt(String key, int value) async {
    setString(key, value.toString());
  }

  Future<int?> getInt(String key) async {
    try {
      return int.tryParse(await getString(key));
    } catch (e) {
      printDebug(e);
      return 0;
    }
  }

  ///String
  setString(String key, String value) async {
    Database db = await DatabaseHelper.instance.db;

    // int updatedId =
    await db.insert(
      sessionManagementTN,
      {
        "key": key,
        "value": value,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String> getString(String key) async {
    try {
      Database db = await DatabaseHelper.instance.db;
      String query = "Select value from $sessionManagementTN "
          " where "
          " key = '$key' ";
      printDebug(query);
      List<Map<String, dynamic>> maps = await db.rawQuery(query);
      printDebug("$key $maps");
      return maps.isNotEmpty ? maps[0]["value"] : "";
    } catch (e) {
      printDebug(e);
      return "";
    }
  }
}
