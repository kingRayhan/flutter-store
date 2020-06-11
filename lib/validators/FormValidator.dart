import 'package:string_validator/string_validator.dart'
    show isEmail, isAlphanumeric;

class FormValidator {
  /**
   * Email validator
   */
  static String emailValidator(String input) {
    if (input.length == 0) return "Required";
    if (!isEmail(input)) return "Invalid email";
    return null;
  }

  static String usernameValidator(String input) {
    if (input.length == 0) return "Required";
    if (input.length < 6) return "At least 6 characters needed";
    return null;
  }

  static String passwordValidator(String input) {
    if (input.length == 0) return "Required";
    if (input.length < 6) return "At least 6 characters needed";
    return null;
  }
}
