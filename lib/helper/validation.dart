class Validation {
  static String validatePassword(String pass) {
    if (pass == null) {
      return "Password can't be null.";
    }

    if (pass.length < 6) {
      return "Password required minimum 6 characters.";
    }

    return null;
  }

  static String validateEmail(String email) {
    if (email == null) {
      return "Email can't be empty";
    }

    var isValid = RegExp(r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)")
        .hasMatch(email);
    if (!isValid) {
      return "Invalid Email";
    }
    return null;
  }
}
