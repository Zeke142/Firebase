import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/sign_in_page.dart'; // Update this path if needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Firebase initialization
  runApp(const DirtHubEliteApp()); // Running your app
}

class DirtHubEliteApp extends StatelessWidget {
  const DirtHubEliteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DirtHub Elite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage(), // Navigate to the Sign In Page first
    );
  }
}