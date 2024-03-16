import 'package:isar/isar.dart';

part "todo.g.dart";

@collection
class Todo {
  Id id = Isar.autoIncrement;
  bool completed;
  String content;

  Todo({required this.completed, required this.content});
}
