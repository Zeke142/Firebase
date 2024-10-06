import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/sign_in_page.dart'; // Update this path if needed
import 'home_page.dart'; // Ensure you have this page created

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Firebase initialization
  runApp(const MyApp()); // Running your app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DirtHub',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const SignInPage(), // Navigate to the Sign In Page first
        '/home': (context) => const HomePage(), // Define your HomePage widget
      },
    );
  }
}