import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_easy/bloc/todo_bloc.dart';
import 'package:todo_easy/components/my_base_scaffold.dart';
import 'package:todo_easy/models/todo.dart';

class NewTodoPage extends StatefulWidget {
  final String? id;

  const NewTodoPage({
    super.key,
    this.id,
  });

  @override
  State<NewTodoPage> createState() => _NewTodoPageState();
}

class _NewTodoPageState extends State<NewTodoPage> {
  var textController = TextEditingController();
  Todo? updatedTodo;
  @override
  initState() {
    super.initState();
    if (widget.id != null) {
      loadTodoData();
    }
  }

  loadTodoData() async {
    final todo = await todoBloc.getTodoById(int.parse(widget.id!));
    if (todo == null) return;
    updatedTodo = todo;
    textController.text = updatedTodo!.content;
  }

  saveTodo() {
    if (textController.text.isEmpty) {
      return;
    }
    if (updatedTodo != null) {
      updateTodo();
    } else {
      createTodo();
    }
    if (context.mounted) {
      context.pop();
    }
  }

  updateTodo() async {
    updatedTodo!.content = textController.text;
    await todoBloc.updateTodo(updatedTodo!);
  }

  createTodo() async {
    final todo = Todo(completed: false, content: textController.text);
    await todoBloc.createTodo(todo);
  }

  @override
  Widget build(BuildContext context) {
    final titleContent = widget.id == null ? "Criar tarefa" : "Editar tarefa";
    final buttonText = widget.id == null ? "Adicionar" : "Salvar";
    final buttonIcon = widget.id == null ? CupertinoIcons.plus : Icons.save;

    return MyBaseScaffold(
        leading: SizedBox(
          width: 40,
          height: 40,
          child: IconButton(
            onPressed: () => context.go("/home"),
            icon: Icon(CupertinoIcons.chevron_back,
                color: Theme.of(context).primaryColor),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                titleContent,
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: TextField(
                  autofocus: true,
                  controller: textController,
                  decoration: const InputDecoration(
                    hintText: "Digite a nova tarefa.",
                  )),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FilledButton(
                    onPressed: () => saveTodo(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(buttonIcon, size: 20),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(buttonText,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    )))
          ],
        ));
  }
}
