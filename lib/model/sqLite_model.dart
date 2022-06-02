import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
            "Create Table Notes(id INTEGER PRIMARY KEY AUTOINCREMENT,description TEXT NOT NULL)");
      },
      version: 1,
    );
  }
}

class Note {
  final int id;
  final String description;

  Note(this.id, this.description);
  Note.fromMap(Map<String, dynamic> item)
      : id = item["id"],
        description = item["description"];

  Map<String, Object> toMap() {
    return {'id': id, 'description': description};
  }
}

class sqliteService {
  Future<int> createIteam(Note note) async {
    int result = 0;
    final Database db = await initializeDB();
    final id = await db.insert('Notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}

class sqliteService {
  Future<List<Note>> getItems() async {
    final db = await sqliteService.initizateDb();
    final List<Map<String, Object>> queryResult =
        await db.query('Notes', orderBy: NoteColumn.createdAt);
    return queryResult.map((e) => Note.fromMap(e)).toList();
  }
}

class sqliteService {
  Future<void> deletIteam(String id) async {
    final db = await sqliteService.initizateDb();

    try {
      await db.delete("Notes", where: "id=?", whereArgs: [id]);
    } catch (error) {
      debugPrint("Something Went Wrong When Deleting Infrmation: $error");
    }
  }
}
