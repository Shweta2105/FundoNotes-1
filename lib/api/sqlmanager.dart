import 'dart:io';
import 'package:fundonotes/models/notes.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlManager {
  static const _dbName = "fundoonotes.db";
  static const _dbVersion = 1;
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
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE NOTES (
      ${NotesField.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${NotesField.title} TEXT,
      ${NotesField.body} TEXT,
      ${NotesField.time} TEXT
    )
''');
  }

  Future<Notes> insertNewNote(Notes note) async {
    Database db = await instance.database;
    final id = await db.insert("NOTES", note.toSqJson());
    print("```````````````${id}```````````````");
    return note.copy(id: id);
  }

  Future<Notes?> getNotes(int id) async {
    Database db = await instance.database;
    final maps = await db.query("NOTES",
        columns: NotesField.values,
        where: '${NotesField.id}=?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Notes.fromSqJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Notes>> getAllNotes() async {
    Database db = await instance.database;
    final result = await db.query("NOTES");
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    print(result);
    return result.map((json) => Notes.fromSqJson(json)).toList();
  }

  Future<int> updateNotes(Notes note) async {
    Database db = await instance.database;
    print("---------------------inside sql update---------------");
    print(note.toSqJson());
    return db.update("NOTES", note.toSqJson(),
        where: '${NotesField.id}=?', whereArgs: [note.iid]);
  }

  Future<int> deleteNotes(int id) async {
    Database db = await instance.database;
    print("-----------------near query----------");
    return db.delete("NOTES", where: '${NotesField.id}=?', whereArgs: [id]);
  }
}
