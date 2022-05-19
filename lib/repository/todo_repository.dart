import 'package:sol_todo_list/dao/todo_dao.dart';
import 'package:sol_todo_list/model/todo.dart';

// short-hand helpers
class TodoRepository {
  final todoDao = TodoDao();

  Future getAllTodos({required String query}) => todoDao.getTodos(query: query);

  Future insertTodo({required Todo todo}) => todoDao.createTodo(todo);

  Future updateTodo({required Todo todo}) => todoDao.updateTodo(todo);

  Future deleteTodoById({required int id}) => todoDao.deleteTodo(id);

  Future deleteAllTodos() => todoDao.deleteAllTodos();
}
