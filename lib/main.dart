import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasksheet_firebase_authentication/firebase_options.dart';
import 'package:tasksheet_firebase_authentication/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}
