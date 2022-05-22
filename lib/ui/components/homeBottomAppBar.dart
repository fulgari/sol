// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sol_todo_list/bloc/todo_bloc.dart';
import 'package:sol_todo_list/ui/sheets/showSearchTodoSheet.dart';

class HomeBottomAppBar extends StatelessWidget {
  const HomeBottomAppBar({Key? key, required this.todoBloc}) : super(key: key);

  final TodoBloc todoBloc;
  // final dynamic showTodoSearchSheet;

  @override
  Widget build(BuildContext context) {
    return (BottomAppBar(
      color: Colors.white,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 0.3, color: Colors.grey.shade300))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  color: Colors.indigoAccent,
                  size: 28,
                  Icons.menu,
                ),
                onPressed: () {
                  //just re-pull UI for testing purposes
                  todoBloc.getTodos(query: '');
                },
              ),
              Expanded(
                  child: Text('Tododd',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'RobotoMono',
                          fontStyle: FontStyle.normal,
                          fontSize: 19))),
              Wrap(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      color: Colors.indigoAccent,
                      size: 28,
                      Icons.search,
                    ),
                    onPressed: () {
                      showTodoSearchSheet(context, todoBloc);
                    },
                  ),
                  Padding(padding: EdgeInsets.only(right: 5)),
                ],
              )
            ],
          )),
    ));
  }
}
