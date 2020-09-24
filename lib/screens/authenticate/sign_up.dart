import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _SignUpFormKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        actions: <Widget>[],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _SignUpFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Email"),
                validator: (val) => _auth.validateEmail(val),
                onChanged: (val) {
                  setState(() => email = val.trim());
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
                validator: (val) => _auth.validatePassword(val),
                onChanged: (val) {
                  setState(() => password = val.trim());
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // Add logic to sign_up here
                  if (_SignUpFormKey.currentState.validate()) {
                    dynamic result = _auth.signUpWithEmailAndPassword(email, password);
                    if (result.hasErrors()) {
                      setState(() {
                        error = result.errorMessage;
                      });
                    }
                  }
                  print(email);
                  print(password);
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Already a member?  ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  TextSpan(
                    text: 'Sign in',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        widget.toggleView();
                      },
                  ),
                ]),
              ),
              SizedBox(
                height: 12.0,
              ),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
