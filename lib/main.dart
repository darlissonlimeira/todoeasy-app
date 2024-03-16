import 'package:flutter/material.dart';
import 'package:todo_easy/database/todo_database.dart';
import 'package:todo_easy/router.dart';
import 'package:todo_easy/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Database.initDatabase();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: themeData,
      routerConfig: appRouter,
      title: 'TodoEasy',
    );
  }
}
