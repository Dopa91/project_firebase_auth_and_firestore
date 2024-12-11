import 'package:flutter/material.dart';
import 'package:tasksheet_firebase_authentication/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Column(
          children: [
            const TextField(),
            FloatingActionButton(onPressed: () {}),
            FloatingActionButton(onPressed: () {}),
          ],
        )),
      ),
    );
  }
}
