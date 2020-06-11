import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helper {
  static void console(Map object) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    print(encoder.convert(object));
  }

  static SuccessSnakbar(String msg, GlobalKey<ScaffoldState> scafoldKey) {
    var _snakbar = SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );
    scafoldKey.currentState.showSnackBar(_snakbar);
  }

  static ErrorSnakbar(String msg, GlobalKey<ScaffoldState> scafoldKey) {
    var _snakbar = SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
    );
    scafoldKey.currentState.showSnackBar(_snakbar);
  }
}
