// // ignore_for_file: avoid_print, depend_on_referenced_packages, prefer_const_declarations, non_constant_identifier_names

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// // ignore: prefer_const_declarations
// final String tableName = "todo";
// final String Column_id = "id";
// final String Column_firstName = "firstName";
// final String Column_lastName = "lastName";
// final String Column_email = "email";

// class SqliteModel {
//   final String firstName;
//   final String lastName;
//   final String email;
//   int id;

//   SqliteModel({
//     required this.lastName,
//     required this.email,
//     required this.firstName,
//     required this.id,
//   });
//   Map<String, dynamic> toMap() {
//     return {
//       "firstName": firstName,
//       "lastName": lastName,
//       "email": email,
//       "id": id,
//     };
//   }
// }

// class ToDoHelper {
//   late Database db;

//   ToDoHelper() {
//     intiDatabase();
//   }

//   Future<void> intiDatabase() async {
//     db = await openDatabase(join(await getDatabasesPath(), "databse.db"),
//         onCreate: (db, version) {
//       return db.execute(
//           "CREATE TABLE $tableName($Column_id INTEGER PRIMARY KEY AUTOINCREMENT, $Column_firstName TEXT,$Column_lastName TEXT,$Column_email Text)");
//     }, version: 1);
//   }

//   Future<void> insertTask(SqliteModel task) async {
//     try {
//       db.insert(tableName, task.toMap(),
//           conflictAlgorithm: ConflictAlgorithm.replace);
//     } catch (_) {
//       print(_);
//     }
//   }

//   Future<List<SqliteModel>> getAllTask() async {
//     final List<Map<String, dynamic>> tasks = await db.query(tableName);

//     List<SqliteModel> myList = [];

//     if (tasks.isNotEmpty) {
//       myList = List.generate(tasks.length, (i) {
//         var id = "id";
//         // return SqliteModel("lastName", "email", "firstName",[id]);
//         return SqliteModel(
//             lastName: "lastName",
//             email: 'email',
//             firstName: "firstName",
//             id: 1);
//       });
//     }
//     return myList;
//   }

//   Future<void> updateList(SqliteModel model) async {
//     try {
//       await db.update(tableName, model.toMap(),
//           conflictAlgorithm: ConflictAlgorithm.replace);
//     } catch (_) {
//       print(_);
//     }
//   }

//   Future<void> deleteList(SqliteModel model) async {
//     try {
//       await db.delete(tableName, model.toMap(),
//           conflictAlgorithm: ConflictAlgorithm.replace);
//     } catch (_) {
//       print(_);
//     }
//   }
// }















// ++++++++++++++++++++++++++++++++++++++++++++++++
// import 'package:flutter/rendering.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// createDatabase() async {
//   String databasePath = await getDatabasesPath();
//   String dbPath = join(databasePath, 'my.db');

//   var database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
//   return database;
// }

// void populateDb(Database database, int version) async {
//   await database.execute("Create Table Customer("
//       "id INTEGER PRIMARY KEY."
//       "first_name TEXT,"
//       "last_name TEXT,"
//       "email TEXT"
//       ")");
// }

// class Customer {
//   int id;
//   String firstName;
//   String lastName;
//   String email;

//   Customer({required this.id, required this.firstName, required this.lastName, required this.email});

//   int get id => id;
//   String get firstName => firstName;
//   String get lastNAme => lastNAme;
//   String get email => email;

//   factory Customer.fromJson(Map<String, dynamic> data) => new Customer(
//         id: data['id'],
//         firstName: data['first_name'],
//         lastName: data['last_name'],
//         email: data['email'],
//       );

//   Map<String, dynamic> toJson() => {
//     "id":id,
//     "first_name":firstName,
//     "last_name":lastNAme,
//     "email":email,
//   };

//   Future<int> createCustomer(Customer customer) async {
//   var result = await database.insert("Customer", customer.toMap());
//   return result;
// }

// }

// createCustomer(Customer customer) async {
//     var result = await database.rawInsert(
//       "INSERT INTO Customer (id,first_name, last_name, email)"
//       " VALUES (${customer.id},${customer.firstName},${customer.lastName},${customer.email})");
//     return result;
//   }

//   Future<List> getCustomers() async {
//   var result = await database.query("Customer", columns: ["id", "first_name", "last_name", "email"]);

//   return result.toList();
// }


// ++++++++++++++++++++++++++++++++++++++++++++++++++
// class sqliteService {
//   Future<Database> initializeDB() async {
//     String path = await getDatabasesPath();

//     return openDatabase(
//       join(path, 'database.db'),
//       onCreate: (database, version) async {
//         await database.execute(
//             "Create Table Notes(id INTEGER PRIMARY KEY AUTOINCREMENT,description TEXT NOT NULL)");
//       },
//       version: 1,
//     );
//   }
// }

// class Note {
//   final int id;
//   final String description;

//   Note(this.id, this.description);
//   Note.fromMap(Map<String, dynamic> item)
//       : id = item["id"],
//         description = item["description"];

//   Map<String, Object> toMap() {
//     return {'id': id, 'description': description};
//   }
// }

// class sqliteService {
//   Future<int> createIteam(Note note) async {
//     int result = 0;
//     final Database db = await initializeDB();
//     final id = await db.insert('Notes', note.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
// }

// class sqliteService {
//   Future<List<Note>> getItems() async {
//     final db = await sqliteService.initizateDb();
//     final List<Map<String, Object>> queryResult =
//         await db.query('Notes', orderBy: NoteColumn.createdAt);
//     return queryResult.map((e) => Note.fromMap(e)).toList();
//   }
// }

// class sqliteService {
//   Future<void> deletIteam(String id) async {
//     final db = await sqliteService.initizateDb();

//     try {
//       await db.delete("Notes", where: "id=?", whereArgs: [id]);
//     } catch (error) {
//       debugPrint("Something Went Wrong When Deleting Infrmation: $error");
//     }
//   }
// }
