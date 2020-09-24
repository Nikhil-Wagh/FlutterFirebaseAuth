import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/models/users.dart';
import 'package:flutter_firebase_auth/screens/authenticate/authenticate.dart';
import 'package:flutter_firebase_auth/screens/authenticate/sign_in.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return Home or Authenticat widget
    if (user != null) {
      return Home();
    } else {
      return Authenticate();
    }
  }
}
