import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_easy/pages/home.dart';
import 'package:todo_easy/pages/login.dart';
import 'package:todo_easy/pages/new_todo.dart';

final GoRouter appRouter = GoRouter(
  redirect: (context, state) async {
    final prefs = await SharedPreferences.getInstance();
    final noAccount = prefs.getBool("noAccount");
    final logginIn = state.fullPath == "/";

    if (noAccount != null) {
      if (logginIn && noAccount) return "/home";
    }

    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
      routes: <RouteBase>[
        GoRoute(
            path: 'home',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            routes: <RouteBase>[
              GoRoute(
                name: "addTodo",
                path: 'newtodo',
                builder: (BuildContext context, GoRouterState state) {
                  return const NewTodoPage();
                },
              ),
              GoRoute(
                name: "editTodo",
                path: 'edittodo/:id',
                builder: (context, state) {
                  return NewTodoPage(
                    id: state.pathParameters["id"],
                  );
                },
              ),
            ]),
      ],
    ),
  ],
);
