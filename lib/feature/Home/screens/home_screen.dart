import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasksheet_firebase_authentication/feature/Home/widgets/download_game_list_button.dart';
import 'package:tasksheet_firebase_authentication/feature/Home/widgets/game_list_card.dart';
import 'package:tasksheet_firebase_authentication/feature/Home/widgets/logout_button.dart';
import 'package:tasksheet_firebase_authentication/feature/shared/main_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  Future<List<Map<String, dynamic>>>? gamesFuture;

  // @override
  // void initState() {
  //   gamesFuture = fetchGames();
  //   super.initState();
  // }

  Future<void> logoutUser() async {
    await authInstance.signOut();
    log("Erfolgreich ausgeloggt");
  }

  Future<List<Map<String, dynamic>>> fetchGames() async {
    await Future.delayed(const Duration(seconds: 2));
    final dataSnapshot = await firestoreInstance.collection('Games').get();
    return dataSnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = authInstance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("GameRate")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  "Willkommen, \n${user?.email}",
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const Expanded(
                  flex: 4,
                  child: SizedBox(),
                ),
                LogoutButton(
                  button: () {
                    logoutUser();
                    Navigator.of(context).pop();
                  },
                ),
                const Expanded(child: SizedBox()),
                DownloadGameListButton(
                  button: () {
                    setState(() {
                      gamesFuture = fetchGames();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            GameListCard(gamesFuture: gamesFuture),
          ],
        ),
      ),
    );
  }
}
