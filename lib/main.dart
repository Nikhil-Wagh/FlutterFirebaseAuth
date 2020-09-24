import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/models/users.dart';
import 'package:flutter_firebase_auth/screens/wrapper.dart';
import 'package:flutter_firebase_auth/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
