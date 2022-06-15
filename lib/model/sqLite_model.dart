import 'dart:io';

import 'package:demo_project/model/showData_fromSqlite.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// ignore_for_file: avoid_print, depend_on_referenced_packages, prefer_const_declarations, non_constant_identifier_names
import 'package:path/path.dart';

// ignore: prefer_const_declarations
final String tableName = "todo";
final String Column_id = "id";
final String Column_firstName = "firstName";
final String Column_lastName = "lastName";
final String Column_email = "email";

class SqliteModel {
  final String firstName;
  final String lastName;
  final String email;
  final int id;

  var getAllRecordFromDb;

  SqliteModel({
    required this.lastName,
    required this.email,
    required this.firstName,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'SqliteModel{id:$id,firstName:$firstName,lastName:$lastName,email:$email}';
  }
}

class ToDoHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'databse.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
          '''CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT, $Column_firstName TEXT,$Column_lastName TEXT,$Column_email Text)''');
    });
  }

  Future<void> insertTask(SqliteModel task) async {
    final db = await database;
    await db.insert('database', task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<SqliteModel>> getAllTask() async {
    final db = await database;
    final List<Map<String, dynamic>> tasks = await db.query(tableName);

    List<SqliteModel> myList = [];

    if (tasks.isNotEmpty) {
      myList = List.generate(tasks.length, (i) {
        var id = "id";
        return SqliteModel(
            lastName: "lastName",
            email: 'email',
            firstName: "firstName",
            id: 1);
      });
    }
    return myList;
  }

  Future<void> updateList(SqliteModel model) async {
    try {
      final db = await database;
      await db.update(tableName, model.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      print(_);
    }
  }

  Future<void> deleteList(SqliteModel model) async {
    try {
      final db = await database;
      await db.delete(
        "todo",
        where: 'id = ?',
        whereArgs: [model.id],
      );
    } catch (_) {
      print(_);
    }
  }

  Future<List<SqliteModel>> getAllRecordFromDb() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_initiateDatabase());

    return List.generate(maps.length, (i) {
      return SqliteModel(
          lastName: maps[i]['lastName'],
          email: maps[i]['email'],
          firstName: maps[i]['firstName'],
          id: maps[i]['id']);
    });
  }
}
