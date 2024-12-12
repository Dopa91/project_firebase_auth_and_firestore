import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasksheet_firebase_authentication/feature/shared/main_app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController mailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    mailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    mailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final userCredential = await authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("Login erfolgreich: ${userCredential.user?.email}");
    } on FirebaseAuthException catch (e) {
      log("Firebase Auth Exception: ${e.message}");
    } catch (e) {
      log("Allgemeiner Fehler: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GameRate")),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Placeholder(
              fallbackWidth: 128,
              fallbackHeight: 256,
            ),
            const SizedBox(
              height: 64,
            ),
            const Text("ERROR"),
            TextField(
              controller: mailController,
              decoration: const InputDecoration(
                labelText: "E-Mail",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                String email = mailController.text;
                String password = passwordController.text;
                loginUser(email, password);
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
