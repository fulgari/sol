import 'package:sol_todo_list/database/database.dart';
import 'package:sol_todo_list/model/todo.dart';

// CRUD
class TodoDao {
  final dbProvider = DatabaseProvider.dbProvider;

  // Adds new Todo records
  Future<int> createTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = db!.insert(todoTABLE, todo.toDatabaseJson());
    return result;
  }

  // Get All Todo records
  // Searches if query string is passed
  Future<List<Todo>> getTodos({List<String>? columns, String? query}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;

    if (query != null && query.isNotEmpty) {
      result = await db!.query(todoTABLE,
          columns: columns,
          where: 'description LIKE ?',
          whereArgs: ["%$query%"]);
    } else {
      result = await db!.query(todoTABLE, columns: columns);
    }

    List<Todo> todos = result.isNotEmpty
        ? result.map(((item) => Todo.fromDatabaseJson(item))).toList()
        : [];

    return todos;
  }

  // Update Todo record
  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.database;
    var result = await db!.update(todoTABLE, todo.toDatabaseJson(),
        where: 'id = ?', whereArgs: [todo.id]);
    return result;
  }

  // Delete Todo record
  Future<int> deleteTodo(int id) async {
    final db = await dbProvider.database;
    var result = await db!.delete(todoTABLE, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  // Delete All Todo records
  Future<int> deleteAllTodos() async {
    final db = await dbProvider.database;
    var result = await db!.delete(todoTABLE);
    return result;
  }
}
