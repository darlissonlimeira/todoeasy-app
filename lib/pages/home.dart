import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_easy/bloc/todo_bloc.dart';
import 'package:todo_easy/components/my_base_scaffold.dart';
import 'package:todo_easy/components/todo_item.dart';
import 'package:todo_easy/models/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final searchController = TextEditingController();
  int currentList = 0;

  @override
  void initState() {
    super.initState();
    todoBloc.init();
    todoBloc.getTodos();
  }

  @override
  void dispose() {
    super.dispose();
    todoBloc.dispose();
  }

  onSearch() {
    Timer(const Duration(milliseconds: 1000), () {
      todoBloc.searchByContent(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyBaseScaffold(
      myKey: _scaffoldKey,
      drawer: _myDrawer(context),
      action: SizedBox(
        width: 40,
        height: 40,
        child: IconButton.filled(
            icon: SvgPicture.asset(
              "assets/icons/profile.svg",
            ),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(
                    Color.fromARGB(150, 200, 191, 255)))),
      ),
      body: _body(context),
    );
  }

  Column _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton(
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.plus,
                size: 20,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Adicionar",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              )
            ],
          ),
          onPressed: () => context.go("/home/newtodo"),
        ),
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Color.fromARGB(50, 200, 191, 255),
                borderRadius: BorderRadius.all(Radius.circular(7))),
            child: Column(
              children: [
                _searchField(context, searchController, onSearch),
                filterTodos(),
                StreamBuilder<List<Todo>>(
                  stream: todoBloc.todosStream,
                  initialData: todoBloc.todos,
                  builder: (context, snapshot) {
                    if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Text("Sem tarefas."));
                    }
                    return _todoList(snapshot.data!);
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget filterTodos() {
    final buttonStyle = TextButton.styleFrom(
        animationDuration: Duration.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: const Color.fromARGB(41, 128, 109, 252));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          TextButton(
            style: currentList == 0 ? buttonStyle : null,
            onPressed: () {
              todoBloc.getTodos();
              setState(() {
                currentList = 0;
              });
            },
            child: const Text(
              "Todas",
            ),
          ),
          TextButton(
            style: currentList == 1 ? buttonStyle : null,
            onPressed: () {
              todoBloc.getByStatus(true);
              setState(() {
                currentList = 1;
              });
            },
            child: const Text(
              "Completas",
            ),
          ),
          TextButton(
              style: currentList == 2 ? buttonStyle : null,
              onPressed: () {
                todoBloc.getByStatus(false);
                setState(() {
                  currentList = 2;
                });
              },
              child: const Text(
                "Incompletas",
              )),
        ],
      ),
    );
  }

  Expanded _todoList(List<Todo> todos) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return TodoItem(
              completed: todos[index].completed,
              content: todos[index].content,
              onEdit: () {
                context.goNamed("editTodo",
                    pathParameters: {"id": "${todos[index].id}"});
                context.pop();
              },
              onDelete: () {
                if (!todos[index].completed) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return _deleteTodoAlertDialog(todos, index, context);
                    },
                  );
                  return;
                }
                setState(() {
                  todoBloc.deleteTodo(todos[index].id);
                });
                context.pop();
              },
              onChanged: (value) {
                todoBloc.updateTodo(todos[index]);
              },
            );
          },
        ),
      ),
    );
  }

  AlertDialog _deleteTodoAlertDialog(
      List<Todo> todos, int index, BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(0),
      titlePadding: const EdgeInsets.all(0),
      actionsPadding: const EdgeInsets.all(10),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      title: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromARGB(50, 200, 191, 255)))),
        child: const Text(
          "Tarefa não completada.\nDeseja mesmo remover?",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              todoBloc.deleteTodo(todos[index].id);
              context.pop();
              context.pop();
            },
            child: const Text(
              "Sim",
              style: TextStyle(color: Colors.red),
            )),
        TextButton(
            onPressed: () {
              context.pop();
              context.pop();
            },
            child: const Text(
              "Não",
              style: TextStyle(color: Colors.black),
            ))
      ],
    );
  }

  Drawer _myDrawer(BuildContext context) {
    return Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: ListView(
          children: [
            DrawerHeader(
                child: Center(
                    child: Image.asset(
              "assets/images/logo.png",
              height: 60,
            ))),
            ListTile(
              title: TextButton(
                  onPressed: () {
                    () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool("noAccount", false);
                    }();
                    context.go("/");
                  },
                  child: const Text(
                    "Sair",
                    style: TextStyle(fontSize: 16),
                  )),
            )
          ],
        ));
  }

  TextField _searchField(BuildContext context,
      TextEditingController searchController, Function onChanged) {
    return TextField(
        controller: searchController,
        onChanged: (value) {
          onChanged();
        },
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          suffixIconConstraints: const BoxConstraints(minWidth: 40),
          suffixIcon: Icon(CupertinoIcons.search,
              size: 25, color: Theme.of(context).primaryColor),
          hintText: "Buscar tarefa...",
        ));
  }
}
