import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/screens/authenticate/sign_in.dart';
import 'package:flutter_firebase_auth/screens/authenticate/sign_up.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  @override
  Widget build(BuildContext context) {
    void toggleView() {
      print('[DEBUG] showSignIn = ' + showSignIn.toString());
      setState(() => showSignIn = !showSignIn);
    }

    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return SignUp(toggleView: toggleView);
    }
  }
}
