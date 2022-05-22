// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sol_todo_list/bloc/todo_bloc.dart';
import 'package:sol_todo_list/model/todo.dart';

void showTodoSearchSheet(BuildContext context, TodoBloc todoBloc) {
  final todoSearchDescriptionFormController = TextEditingController();
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
                            controller: todoSearchDescriptionFormController,
                            textInputAction: TextInputAction.newline,
                            maxLines: 4,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: 'Search for todo...',
                              labelText: 'Search *',
                              labelStyle: TextStyle(
                                  color: Colors.indigoAccent,
                                  fontWeight: FontWeight.w500),
                            ),
                            validator: (String? value) {
                              return value!.contains('@')
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
                                Icons.search,
                                size: 22,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                /*This will get all todos
                                  that contains similar string
                                  in the textform
                                  */
                                todoBloc.getTodos(
                                    query: todoSearchDescriptionFormController
                                        .value.text);
                                //dismisses the bottomsheet
                                Navigator.pop(context);
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
