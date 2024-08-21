import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: Color(0xfff4f4f9),
  secondaryHeaderColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffF4F4F9),
    // color: Colors.black,
  ),
  scaffoldBackgroundColor: Color(0xffF4F4F9),
  cardTheme: CardTheme(
    color: Color(0xffFFFFFF),
  ),
  cardColor: Color(0xffFFFFFF),
  brightness: Brightness.light,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Color(0xff0000FF),
    unselectedItemColor: Color(0xffB3B3B3),
    selectedLabelStyle: TextStyle(
      color: Color(0xff0000FF),
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(color: Color(0xffB3B3B3)),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: Color(0xff181819),
  secondaryHeaderColor: Color(0xffF4F4F9),
  appBarTheme: AppBarTheme(
    // color: Color(0xffF4F4F9),
    backgroundColor: Colors.black,
  ),
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xff181819),
  cardTheme: CardTheme(
    color: Color(0xff2E2E2F),
  ),
  cardColor: Color(0xff2E2E2F),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xff0F0F10),
    selectedItemColor: Color(0xff9595FE),
    unselectedItemColor: Color(0xffB3B3B3),
    selectedLabelStyle: TextStyle(
      color: Color(0xff9595FE),
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(color: Color(0xffB3B3B3)),
  ),
);
