import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart'; // Add this for third-party sign-in buttons
import 'package:google_sign_in/google_sign_in.dart'; // For Google Sign-In
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart'; // For Apple and Facebook Sign-In
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

  // Function to handle Email/Password sign-in
  Future<void> _signInWithEmail() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DirtHubEliteApp()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to sign in. Please check your credentials.';
      });
      debugPrint("Error signing in with Email: $e");
    }
  }

  // Function to handle Google sign-in
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DirtHubEliteApp()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to sign in with Google.';
      });
      debugPrint("Error signing in with Google: $e");
    }
  }

  // Function to handle Facebook sign-in
  Future<void> _signInWithFacebook() async {
    try {
      await FirebaseAuthOAuth().openSignInFlow("facebook.com", ["email"], {});
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DirtHubEliteApp()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to sign in with Facebook.';
      });
      debugPrint("Error signing in with Facebook: $e");
    }
  }

  // Function to handle Apple sign-in
  Future<void> _signInWithApple() async {
    try {
      await FirebaseAuthOAuth().openSignInFlow("apple.com", ["email"], {});
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DirtHubEliteApp()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to sign in with Apple.';
      });
      debugPrint("Error signing in with Apple: $e");
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
              onPressed: _signInWithEmail,
              child: const Text('Sign In with Email'),
            ),
            const SizedBox(height: 10),
            SignInButton(
              Buttons.Google,
              onPressed: _signInWithGoogle,
            ),
            SignInButton(
              Buttons.Facebook,
              onPressed: _signInWithFacebook,
            ),
            SignInButton(
              Buttons.Apple,
              onPressed: _signInWithApple,
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