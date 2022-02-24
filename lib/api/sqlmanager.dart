import 'dart:io';
import 'package:fundonotes/models/notes.dart';
import 'package:fundonotes/models/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlManager {
  static final dbName = "fundoonotes.db";
  static final _dbVersion = 1;
  // static final tableName = "";

  SqlManager._privateConstructor();
  static final SqlManager instance = SqlManager._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE NOTES (
      id INTEGER NOT NULL AUTOINCREMENT,
      title TEXT ,
      body TEXT,
    )
''');
  }

  insertNewNote(Notes note) async {
    Database db = await instance.database;
    db.insert("NOTES", note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<dynamic> getNotes() async {
    Database db = await instance.database;
    var result = await db.query("NOTES");
    if (result.length == 0) {
      return null;
    } else {
      return result.toList();
    }
  }
}
