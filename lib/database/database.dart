import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final todoTABLE = 'Todo';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();
  Database? _database;

  // 单例 getter，使用 cached 的 Database
  Future<Database?> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //"SolTodo.db is our database instance name
    String path = join(documentsDirectory.path, "SolTodo.db");

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  //This is optional, and only used for changing DB schema migrations
  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    /* SQLITE doesn't have boolean type
    so we store isDone as integer where 0 is false
    and 1 is true */
    final String sql = 'CREATE TABLE $todoTABLE (id INTEGER PRIMARY KEY, '
        'description TEXT, isDone INTEGER)';
    await database.execute(sql);
  }
}
