import 'dart:convert';

class Helper {
  static void console(Map object) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    print(encoder.convert(object));
  }
}
