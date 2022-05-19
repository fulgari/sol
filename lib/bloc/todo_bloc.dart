import 'dart:async';

import 'package:sol_todo_list/model/todo.dart';
import 'package:sol_todo_list/repository/todo_repository.dart';

// 类似 Redux 的发布/订阅状态管理
class TodoBloc {
  //Get instance of the Repository
  final _todoRepository = TodoRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _todoController =
      StreamController<List<Todo>>.broadcast(); // 返回一个广播流，能够被多个订阅者订阅

  get todos => _todoController.stream; // 返回一个流，可以通过流获取到状态

  TodoBloc() {
    getTodos(query: '');
  }

  getTodos({required String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    // sink 类似 EventEmitter.emit 将新的数据添加到流中，更新数据
    _todoController.sink.add(await _todoRepository.getAllTodos(query: query));
  }

  addTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo: todo);
    getTodos(query: ''); // Update the list
  }

  updateTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo: todo);
    getTodos(query: ''); // Update the list
  }

  deleteTodoById(int id) async {
    await _todoRepository.deleteTodoById(id: id);
    getTodos(query: ''); // Update the list
  }

  deleteAllTodos(int id) async {
    await _todoRepository.deleteAllTodos();
    getTodos(query: ''); // Update the list
  }

  dispose() {
    _todoController.close();
  }
}
