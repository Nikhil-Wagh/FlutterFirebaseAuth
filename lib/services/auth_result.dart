import 'package:flutter_firebase_auth/models/users.dart';

class AuthResult {
  User user;
  String errorMessage;

  bool hasErrors() {
    if (this.errorMessage.isEmpty || this.user == null)
      return true;
    else
      return false;
  }

  AuthResult(User user, String errorMessage) {
    this.user = user;
    this.errorMessage = errorMessage;
  }
}
