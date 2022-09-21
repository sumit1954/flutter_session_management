import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';

import 'session_manager.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  ///OR
  factory DatabaseHelper() => instance;

  static Database? _database;

  Future<Database> get db async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  final dbName = "sessionManagement";

  _initDatabase() async {
    printDebug("_initDatabase");
    String path = join(await getDatabasesPath(), '$dbName.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute("CREATE TABLE $sessionManagementTN ("
          ' localId INTEGER PRIMARY KEY AUTOINCREMENT '
          ' ,key TEXT UNIQUE'
          ' ,value TEXT )');
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {});
  }
}

const sessionManagementTN = "SessionManagement";
