import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xfff4f4f9),
  secondaryHeaderColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xffF4F4F9),
    // color: Colors.black,
  ),
  scaffoldBackgroundColor: const Color(0xffF4F4F9),
  cardTheme: const CardTheme(
    color: Color(0xffFFFFFF),
  ),
  cardColor: const Color(0xffFFFFFF),
  brightness: Brightness.light,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xff0000FF),
    unselectedItemColor: Color(0xffB3B3B3),
    selectedLabelStyle: TextStyle(
      color: Color(0xff0000FF),
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(color: Color(0xffB3B3B3)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff0000FF),
      foregroundColor: const Color(0xffFFFFFF),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xff181819),
  secondaryHeaderColor: const Color(0xffF4F4F9),
  appBarTheme: const AppBarTheme(
    // color: Color(0xffF4F4F9),
    backgroundColor: Colors.black,
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xff181819),
  cardTheme: const CardTheme(
    color: Color(0xff2E2E2F),
  ),
  cardColor: const Color(0xff2E2E2F),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xff0F0F10),
    selectedItemColor: Color(0xff9595FE),
    unselectedItemColor: Color(0xffB3B3B3),
    selectedLabelStyle: TextStyle(
      color: Color(0xff9595FE),
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(color: Color(0xffB3B3B3)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff9595FE),
      foregroundColor: const Color(0xffFFFFFF),
    ),
  ),
);
