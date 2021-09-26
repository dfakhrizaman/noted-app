import 'dart:io';
import 'package:noted_app/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  static final DatabaseHandler instance = DatabaseHandler._init();

  DatabaseHandler._init();

  static Database? _database;

  String notesTable = 'notes_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colIsDone = 'isDone';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initializeDatabase();
    return _database!;
  }

  void createDatabase(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $notesTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colDate TEXT, $colIsDone BOOLEAN NOT NULL)');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Database> initializeDatabase() async {
    // Get directory path for db storage
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/create db
    var notesDatabase =
        openDatabase(path, version: 1, onCreate: createDatabase);

    print(notesDatabase);
    return notesDatabase;
  }

  // Get all note objects from db
  Future<List<NoteModel>> getNoteList() async {
    final db = await instance.database;

    var list = await db.query(notesTable, orderBy: '$colId ASC');
    return list.map((note) => NoteModel.fromJSON(note)).toList();
  }

  // Insert a note to db
  Future<int> insertNote(NoteModel note) async {
    final db = await instance.database;

    var result = await db.insert(
      notesTable,
      note.toMap(),
    );

    return result;
  }

  // Update a note in db
  // Future<int> updateNote(NoteModel note) async {
  //   final db = await instance.database;
  //   var result = await db.update(
  //     notesTable,
  //     note.toMap(),
  //     where: '$colId = ?',
  //     whereArgs: [note.id],
  //   );

  //   return result;
  // }

  // Delete a note in db
  // Future<int> deleteNote(NoteModel note) async {
  //   final db = await instance.database;

  //   int result =
  //       await db.rawDelete('DELETE FROM $notesTable WHERE $colId = ${note.id}');

  //   return result;
  // }

  // Get number of notes in db
  Future getCount() async {
    final db = await instance.database;

    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $notesTable');

    var result = Sqflite.firstIntValue(x);
    return result;
  }
}
