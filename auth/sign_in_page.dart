import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_page.dart'; // Import your signup page
import '../app/dirt_hub_elite_app.dart'; // Import your main app

class SignInPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _loginUser(LoginData data) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: data.name,
        password: data.password,
      );
      return null; // Successful login
    } on FirebaseAuthException catch (e) {
      return e.message; // Return Firebase error message
    }
  }

  Future<String?> _signUpUser(SignupData data) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: data.name!,
        password: data.password!,
      );
      return null; // Successful signup
    } on FirebaseAuthException catch (e) {
      return e.message; // Return Firebase error message
    }
  }

  Future<String?> _recoverPassword(String name) async {
    try {
      await _auth.sendPasswordResetEmail(email: name);
      return null; // Successful password recovery
    } on FirebaseAuthException catch (e) {
      return e.message; // Return Firebase error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'DirtHub',
      onLogin: _loginUser,
      onSignup: _signUpUser,
      onSubmitAnimationCompleted: () {
        // Navigate to the main app page after successful login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DirtHubEliteApp()),
        );
      },
      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
        primaryColor: Colors.blueAccent,
      ),
    );
  }
}
