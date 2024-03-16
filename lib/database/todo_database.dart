import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_easy/models/todo.dart';

class Database {
  static late Isar isar;

  static Future<void> initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TodoSchema],
      directory: dir.path,
    );

    // Add initial todos on app first run
    // if the key not exists, then load initial data
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("loadedInitialData")) {
      await _putInitialData();
    }
  }

  static Future<void> _putInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    // Set this key when load initial data
    prefs.setBool("loadedInitialData", true);
    await isar.writeTxn(() async {
      await isar.todos.putAll([
        Todo(completed: true, content: "Code."),
        Todo(completed: false, content: "Eat."),
        Todo(completed: false, content: "Ready."),
      ]);
    });
    log("Loading initial data.");
  }

  Future<void> saveTodo(Todo todo) async {
    await isar.writeTxn(() => isar.todos.put(todo));
  }

  Future<List<Todo>> getTodos() async {
    final todos = await isar.todos.where().findAll();
    return todos;
  }

  Future<Todo?> getTodoById(int todoId) async {
    final todo = await isar.todos.get(todoId);
    if (todo == null) {
      log("INFO: todo not found with id: $todoId");
      return null;
    }
    return todo;
  }

  Future<void> updateTodo(Todo updatedTodo) async {
    await isar.writeTxn(() async {
      final todo = await getTodoById(updatedTodo.id);
      if (todo == null) {
        return;
      }
      todo.completed = updatedTodo.completed;
      todo.content = updatedTodo.content;
      await isar.todos.put(todo);
      log("Uptade todo ${updatedTodo.id}");
    });
  }

  Future<void> deleteTodo(int todoId) async {
    await isar.writeTxn(() async {
      if (await getTodoById(todoId) == null) {
        return;
      }
      await isar.todos.delete(todoId);
      log("Deleting todo $todoId");
    });
  }
}
