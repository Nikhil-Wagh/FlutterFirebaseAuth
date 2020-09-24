import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_auth/models/users.dart';
import 'package:flutter_firebase_auth/services/auth_result.dart' as mAuthResult;

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser firebaseUser) {
    if (firebaseUser == null) return null;
    return User(firebaseUser.uid, firebaseUser.email, firebaseUser.displayName, firebaseUser.phoneNumber, firebaseUser.photoUrl);
  }

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  validateEmail(String email) {
    if (email.isEmpty)
      return 'Enter an email';
    else if (!email.contains('@') || email.split('@').length < 2 || (!email.split('@')[1].contains('.com')))
      return 'Not a valid email address';
    else
      null;
  }

  validatePassword(String password) {
    if (password.length < 6) {
      return 'Password must be atleast of 6 characters';
    } else
      return null;
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      print('[ERROR] Signing failed');
      print(e);
      return null;
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return mAuthResult.AuthResult(_userFromFirebaseUser(result.user), '');
    } on PlatformException catch (e) {
      print("exception in signUpWithEmailAndPassword");
      print(e);
      return mAuthResult.AuthResult(null, e.message);
    } catch (e) {
      print('[ERROR] unexpected error in signUpWithEmailAndPassword');
      print(e);
      // TODO: Notify dev
      return mAuthResult.AuthResult(null, 'Error while trying to sign up');
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return _userFromFirebaseUser(result.user);
    } on PlatformException catch (e) {
      print('error = ' + e.message);
      return mAuthResult.AuthResult(null, e.message);
    } catch (e) {
      print('[ERROR] Error in signInWithEmailAndPassword');
      print(e);
      //Notify dev about this error
      return mAuthResult.AuthResult(null, 'Error while trying to sign in');
    }
  }
}
