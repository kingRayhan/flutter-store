import 'package:flutter/material.dart';
import 'package:flutter_store/screens/LoginScreen.dart';
import 'package:flutter_store/screens/RegisterScreen.dart';

Map<String, Widget Function(BuildContext)> AppRoutes(BuildContext context) => {
      "/login": (BuildContext context) => LoginScreen(),
      "/register": (BuildContext context) => RegisterScreen(),
    };
