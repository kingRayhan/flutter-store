import 'package:flutter/material.dart';
import 'package:flutter_store/AppTheme.dart';
import 'package:flutter_store/Routes.dart';
import 'package:flutter_store/screens/LoginScreen.dart';
import 'package:flutter_store/screens/RegisterScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter E-Commerce',
      theme: AppTheme.defaultTheme(),
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
      routes: AppRoutes(context),
    );
  }
}
