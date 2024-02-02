import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get customTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: purple500,
      colorScheme: ColorScheme.light(primary: purple500, secondary: teal200),
      textTheme: textTheme,
    );
  }

  static const Color purple500 = Color(0xFF6746C3);
  static const Color teal200 = Color(0xFF03DAC5);

  static const TextTheme textTheme = TextTheme(
    headline1: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    headline5: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    headline6: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16.0),
    bodyText2: TextStyle(fontSize: 14.0),
    caption: TextStyle(fontSize: 12.0),
    button: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    overline: TextStyle(fontSize: 10.0),
    subtitle1: TextStyle(fontSize: 16.0),
    subtitle2: TextStyle(fontSize: 14.0),
  );
}
