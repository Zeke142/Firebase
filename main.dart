import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/sign_in_page.dart'; // Ensure this path is correct
import 'pages/home_page.dart'; // Ensure you have this page created

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Initialize Firebase
  runApp(const MyApp()); // Run your app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DirtHub',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login', // Set the initial route to the Sign In Page
      routes: {
        '/login': (context) => const SignInPage(), // Navigate to Sign In Page
        '/home': (context) => const HomePage(), // Define your HomePage widget
      },
    );
  }
}
