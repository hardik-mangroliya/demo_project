// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore_for_file: avoid_print, depend_on_referenced_packages, prefer_const_declarations, non_constant_identifier_names
import 'package:path/path.dart';
import '../module/home/model/user_model.dart';

class DatabaseHelper {
  String dbName = "mydatabse.db";
  int dbversion = 1;
  String tablename = "myTable";

  static const columnId = "id";
  static const columnuserId = "userId";
  static const columnfirstName = "first_name";
  static const columnlastName = "last_name";
  static const columnemail = "email";
  static const columncreateAt = "createAt";
  static const columnupdateAt = "updateAt";
  static const columnBio = "Bio";
  static const columnFavourite = "Favourite";

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database!;

    _database = await initiateDatabase();
    return _database;
  }

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbversion, onCreate: oncreat);
  }

  Future oncreat(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $tablename($columnId String, $columnfirstName TEXT,$columnlastName TEXT,$columnemail Text,$columncreateAt Text,$columnupdateAt Text,$columnBio Text,$columnFavourite )''');
  }

  Future<void> insertAllUserToDB(List<User> userlist) async {
    final db = await database;
    for (int i = 0; i < userlist.length; i++) {
      Map<String, dynamic> userdata = {
        DatabaseHelper.columnId: userlist[i].id,
        DatabaseHelper.columnfirstName: userlist[i].firstName,
        DatabaseHelper.columnlastName: userlist[i].lastName,
        DatabaseHelper.columnemail: userlist[i].email,
        DatabaseHelper.columnupdateAt: userlist[i].updatedAt.toString(),
        DatabaseHelper.columncreateAt: userlist[i].createdAt.toString(),
      };
      print(userlist[i].firstName);
      await db!.insert(tablename, userdata);
    }
  }

  Future update(User usermodel) async {
    final db = await database;
    return await db!.update(tablename,
        {columnBio: usermodel.bio, columnFavourite: usermodel.favourite},
        where: "$columnId=?", whereArgs: [usermodel.id]);
  }

  Future<List<User>> search(String value) async {
    final db = await database;
    var result = await db!.rawQuery(
        " SELECT * FROM $tablename WHERE $columnfirstName LIKE '%$value%' OR $columnlastName LIKE '%$value%'");
    List<User> list =
        result.isNotEmpty ? result.map((e) => User.fromJson(e)).toList() : [];
    return list;
  }

  Future delete() async {
    final db = await database;
    return await db!.delete(tablename);
  }

  Future<List<User>> favourite() async {
    final db = await database;
    var listofFav = await db!.rawQuery("SELECT * FROM $tablename WHERE $columnFavourite LIKE 0");
    List<User> list=listofFav.isNotEmpty ? listofFav.map((e) => User.fromJson(e)).toList() : [];
    return list;
  }

  // Future<List<User>> favourite() async {
  //   final db = await database;
  //   var templist = await db!
  //       .rawQuery("""SELECT * FROM $tablename WHERE $columnFavourite LIKE '0'""");
  //   List<User> list = templist.isNotEmpty
  //       ? templist.map((e) => User.fromJson(e)).toList()
  //       : [];
  //   return list;
  // }




  Future<List<User>> getAllRecordFromDB() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(tablename);

    var tempList = List.generate(maps.length, (i) {
      return User(
          id: maps[i][columnId],
          createdAt: maps[i][columncreateAt],
          updatedAt: maps[i][columnupdateAt],
          firstName: maps[i][columnfirstName],
          lastName: maps[i][columnlastName],
          email: maps[i][columnemail],
          bio: maps[i][columnBio],
          favourite: maps[i][columnFavourite]);
    });
    print(tempList);
    return tempList;
  }
}
