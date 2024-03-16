import 'dart:async';
import 'dart:developer';

import 'package:todo_easy/database/todo_database.dart';
import 'package:todo_easy/models/todo.dart';

class TodoBloc {
  final Database db = Database();
  List<Todo> todos = [];
  StreamController<List<Todo>> _todosController = StreamController();

  Stream<List<Todo>> get todosStream => _todosController.stream;

  getTodos() async {
    _todosController.sink.add(await db.getTodos());
  }

  updateTodo(Todo todo) async {
    todo.completed = !todo.completed;
    await db.updateTodo(todo);
    _todosController.sink.add(await db.getTodos());
  }

  getByStatus(bool status) async {
    final todos = await db.getTodos();
    final filtered =
        todos.where((element) => element.completed == status).toList();
    _todosController.sink.add(filtered);
  }

  deleteTodo(int id) async {
    await db.deleteTodo(id);
    getTodos();
  }

  createTodo(Todo todo) async {
    await db.saveTodo(todo);
    getTodos();
  }

  getTodoById(int id) async {
    final todo = await db.getTodoById(id);
    return todo;
  }

  searchByContent(String search) async {
    final todos = await db.getTodos();
    final result = todos
        .where((todo) =>
            todo.content.toLowerCase().contains(search.trim().toLowerCase()))
        .toList();
    _todosController.sink.add(result);
  }

  void dispose() {
    _todosController.close();
    log("Closing todos bloc stream");
  }

  void init() {
    if (_todosController.isClosed) {
      _todosController = StreamController();
      log("Starting todos bloc stream");
    }
  }
}

final todoBloc = TodoBloc();
