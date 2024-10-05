import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'auth/sign_in_page.dart';  // Correct import for SignInPage
import 'app/dirt_hub_elite_app.dart';  // Correct import for DirtHubEliteApp

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets are bound
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp()); // Call MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DirtHub Elite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return const DirtHubEliteApp(); // User is signed in
          } else {
            return const SignInPage(); // User is not signed in
          }
        },
      ),
    );
  }
}