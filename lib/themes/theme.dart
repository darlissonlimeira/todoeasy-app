import 'package:flutter/material.dart';

final themeData = ThemeData(
    primaryColor: const Color.fromARGB(255, 128, 109, 252),
    fontFamily: "Raleway",
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
          padding: const MaterialStatePropertyAll<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 12, horizontal: 7)),
          shape: MaterialStatePropertyAll<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
          backgroundColor: const MaterialStatePropertyAll<Color>(
              Color.fromARGB(255, 128, 109, 252))),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      // contentPadding: EdgeInsets.all(10),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        borderSide:
            BorderSide(width: 1, color: Color.fromARGB(255, 128, 109, 252)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        borderSide:
            BorderSide(width: 2, color: Color.fromARGB(255, 128, 109, 252)),
      ),
    ));
