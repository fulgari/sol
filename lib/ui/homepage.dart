import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  // final TodoBloc todoBloc = TodoBloc();
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
                // child: getTodosWidget()
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Please enter...'),
                  onChanged: (value) {},
                ))));
  }
}

// Widget getTodosWidget() {
//   /*The StreamBuilder widget,
//     basically this widget will take stream of data (todos)
//     and construct the UI (with state) based on the stream
//     */
//   return StreamBuilder(
//     stream: todoBloc.todos,
//     builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
//       return getTodoCardWidget(snapshot);
//     },
//   );
// }
