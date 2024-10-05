import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../app/dirt_hub_elite_app.dart';  // Correct import path for DirtHubEliteApp

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});  // Using super parameter for key

  @override
  SignInPageState createState() => SignInPageState();  // Public state class
}

class SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  // Function to handle sign-in
  Future<void> _signIn() async {
    try {
      // Sign in the user
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Check if the widget is still mounted before navigating
      if (mounted) {
        // Navigate to DirtHubEliteApp after successful sign-in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DirtHubEliteApp()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        // Differentiate error messages based on the error code
        if (e.code == 'user-not-found') {
          _errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'Wrong password provided for that user.';
        } else {
          _errorMessage = 'Failed to sign in. Please check your credentials.';
        }
      });
      debugPrint("Error signing in: $e");  // Use debugPrint for logging
    } catch (e) {
      setState(() {
        _errorMessage = 'An unknown error occurred.';
      });
      debugPrint("Error signing in: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text('Sign In'),
            ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}