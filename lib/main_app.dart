import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasksheet_firebase_authentication/feature/Home/screens/home_screen.dart';
import 'package:tasksheet_firebase_authentication/feature/Login/screens/login_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginLogic(),
    );
  }
}

final authInstance = FirebaseAuth.instance;
final firestoreInstance = FirebaseFirestore.instance;

class LoginLogic extends StatelessWidget {
  const LoginLogic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authInstance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
