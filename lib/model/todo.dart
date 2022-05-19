class Todo {
  int id;
  //description is the text we see on
  //main screen card text
  String description;
  //isDone used to mark what Todo item is completed
  bool isDone = false;

  //When using curly braces { } we note dart that
  //the parameters are optional
  Todo({required this.id, required this.description, required this.isDone});

  // factory 类似单例构造函数，即使多次调用也返回同一个 class 的实例对象
  factory Todo.fromDatabaseJson(Map<String, dynamic> data) => Todo(
        //Factory method will be used to convert JSON objects that
        //are coming from querying the database and converting
        //it into a Todo object
        id: data['id'],
        description: data['description'],
        //Since sqlite doesn't have boolean type for true/false,
        //we will use 0 to denote that it is false
        //and 1 for true
        isDone: data['isDone'] == 0 ? false : true,
      );

  // Todo._internal(this.id, this.description, this.isDone);

  Map<String, dynamic> toDatabaseJson() => {
        //A method will be used to convert Todo objects that
        //are to be stored into the datbase in a form of JSON
        "id": this.id,
        "description": this.description,
        "isDone": this.isDone == false ? 0 : 1
      };
}
