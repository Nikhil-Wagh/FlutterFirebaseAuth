import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _SignInFormKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        actions: <Widget>[],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _SignInFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Email"),
                validator: (value) => _auth.validateEmail(value),
                onChanged: (val) {
                  setState(() => email = val.trim());
                },
              ),
              SizedBox(height: 8.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
                validator: (value) => _auth.validatePassword(value),
                onChanged: (val) {
                  setState(() => password = val.trim());
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_SignInFormKey.currentState.validate()) {
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result.hasErrors()) {
                      setState(() {
                        error = result.errorMessage;
                      });
                    }
                  }
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'New to this?  ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    TextSpan(
                      text: 'Sign up',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          print('Navigating to Sign In');
                          widget.toggleView();
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
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
