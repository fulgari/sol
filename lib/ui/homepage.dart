import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sol_todo_list/bloc/todo_bloc.dart';
import 'package:sol_todo_list/model/todo.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  //We load our Todo BLoC that is used to get
  //the stream of Todo for StreamBuilder
  final TodoBloc todoBloc = TodoBloc();
  final String title;

  final DismissDirection _dismissDirection = DismissDirection.horizontal;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 2.0),
                child: getTodosWidget())));
  }

  Widget getTodosWidget() {
    /*The StreamBuilder widget,
    basically this widget will take stream of data (todos)
    and construct the UI (with state) based on the stream
    */
    return StreamBuilder(
      stream: todoBloc.todos,
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
        return getTodoCardWidget(snapshot);
      },
    );
  }

  Widget getTodoCardWidget(AsyncSnapshot<List<Todo>> snapshot) {
    /*Since most of our operations are asynchronous
    at initial state of the operation there will be no stream
    so we need to handle it if this was the case
    by showing users a processing/loading indicator*/
    if (snapshot.hasData) {
      /*Also handles whenever there's stream
      but returned returned 0 records of Todo from DB.
      If that the case show user that you have empty Todos
      */
      return snapshot.data!.isNotEmpty
          ? ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, itemPosition) {
                Todo todo = snapshot.data![itemPosition];
                final Widget dismissibleCard = new Dismissible(
                    background: Container(
                      child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Deleting",
                                style: TextStyle(color: Colors.white)),
                          )),
                      color: Colors.redAccent,
                    ),
                    onDismissed: (direction) {
                      /*The magic
              delete Todo item by ID whenever
              the card is dismissed
              */
                      todoBloc.deleteTodoById(todo.id);
                    },
                    direction: _dismissDirection,
                    key: new ObjectKey(todo),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(color: Colors.grey.shade200, width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.white,
                      child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                todo.isDone = !todo.isDone;
                                /*
                                  Another magic.
                                  This will update Todo isDone with either
                                  completed or not
                                */
                                todoBloc.updateTodo(todo);
                              },
                              child: Container(
                                child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: todo.isDone
                                        ? const Icon(
                                            Icons.done,
                                            size: 26.0,
                                            color: Colors.indigoAccent,
                                          )
                                        : const Icon(
                                            Icons.check_box_outline_blank,
                                            size: 26.0,
                                            color: Colors.tealAccent,
                                          )),
                              )),
                          title: Text(todo.description,
                              style: TextStyle(
                                  fontSize: 16.5,
                                  fontFamily: 'RobotoMono',
                                  fontWeight: FontWeight.w500,
                                  decoration: todo.isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none))),
                    ));
                return dismissibleCard;
              })
          : Container(
              child: Center(
              child: noTodoMessageWidget(),
            ));
    } else {
      /*since most of our I/O operations are done
        outside the main thread asynchronously
        we may want to display a loading indicator
        to let the use know the app is currently
        processing*/
      return Center(child: loadingData());
    }
  }

  Widget loadingData() {
    todoBloc.getTodos(query: '');
    return Container(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
          CircularProgressIndicator(),
          Text('Loading...',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
        ])));
  }

  Widget noTodoMessageWidget() {
    return Container(
      child: const Text(
        "Start adding Todo...",
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
      ),
    );
  }

  dispose() {
    /*close the stream in order
    to avoid memory leaks
    */
    todoBloc.dispose();
  }
}
