import 'package:flutter/material.dart';
import 'package:todo_easy/components/my_app_bar.dart';

class MyBaseScaffold extends StatelessWidget {
  final Widget? leading;
  final Widget? action;
  final Drawer? drawer;
  final Widget body;
  final GlobalKey<ScaffoldState>? myKey;

  const MyBaseScaffold(
      {super.key,
      required this.body,
      this.leading,
      this.action,
      this.drawer,
      this.myKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: myKey,
      drawer: SafeArea(child: drawer ?? const SizedBox()),
      appBar: MyAppBar(
        leading: leading,
        action: action,
      ).build(context) as PreferredSizeWidget,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: body,
      ),
    );
  }
}
