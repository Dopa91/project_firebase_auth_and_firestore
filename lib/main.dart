import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasksheet_firebase_authentication/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

final authInstance = FirebaseAuth.instance;

Stream<User?> get onAuthStateChanged => authInstance.authStateChanges();

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late TextEditingController mailController;
  late TextEditingController passwordController;

  Future<void> loginUser(String email, String password) async {
    try {
      final userCredential = await authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Login erfolgreich: ${userCredential.user?.email}");
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Exception: ${e.message}");
    } catch (e) {
      print("Allgemeiner Fehler: $e");
    }
  }

  Future<void> logoutUser() async {
    try {
      await authInstance.signOut();
      print("Erfolgreich ausgeloggt");
    } catch (e) {
      print("Fehler beim Loggout: $e");
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: mailController,
              decoration: const InputDecoration(labelText: "E-Mail"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            FloatingActionButton(
              onPressed: () {
                String mail = mailController.text;
                String password = passwordController.text;

                loginUser(mail, password);
              },
              child: const Text("Login"),
            ),
            FloatingActionButton(
              onPressed: logoutUser,
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
