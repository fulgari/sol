// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sol_todo_list/bloc/todo_bloc.dart';
import 'package:sol_todo_list/model/todo.dart';

void showAddTodoSheet(BuildContext context, TodoBloc todoBloc) {
  final todoDescriptionFormController = TextEditingController();
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            color: Colors.transparent,
            child: Container(
              height: 230,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 25.0, right: 15, bottom: 30),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: todoDescriptionFormController,
                            textInputAction: TextInputAction.newline,
                            maxLines: 4,
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w400),
                            autofocus: true,
                            decoration: const InputDecoration(
                                hintText: 'I have to...',
                                labelText: 'New Todo',
                                labelStyle: TextStyle(
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.w500)),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Empty description!';
                              }
                              return value.contains('')
                                  ? 'Do not use the @ char.'
                                  : null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, top: 15),
                          child: CircleAvatar(
                            backgroundColor: Colors.indigoAccent,
                            radius: 18,
                            child: IconButton(
                              icon: Icon(
                                Icons.save,
                                size: 22,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                final newTodo = Todo(
                                    id: DateTime.now().microsecond,
                                    description: todoDescriptionFormController
                                        .value.text,
                                    isDone: false);
                                if (newTodo.description.isNotEmpty) {
                                  /*Create new Todo object and make sure
                                    the Todo description is not empty,
                                    because what's the point of saving empty
                                    Todo
                                    */
                                  todoBloc.addTodo(newTodo);

                                  //dismisses the bottomsheet
                                  Navigator.pop(context);
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
