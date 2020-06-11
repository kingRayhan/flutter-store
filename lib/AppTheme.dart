import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData defaultTheme() {
    return ThemeData(
      primaryColor: Colors.teal,
      accentColor: Colors.teal,
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.white),
        headline2: TextStyle(fontSize: 35.0, fontStyle: FontStyle.italic),
        bodyText1: TextStyle(fontSize: 18.0),
      ),
      buttonColor: Colors.teal,
    );
  }
}
