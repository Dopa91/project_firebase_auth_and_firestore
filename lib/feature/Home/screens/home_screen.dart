import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tasksheet_firebase_authentication/main_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> gamesFuture;

  @override
  void initState() {
    super.initState();
    gamesFuture = fetchGames();
  }

  Future<void> logoutUser() async {
    await authInstance.signOut();
    log("Erfolgreich ausgeloggt");
  }

  Future<List<Map<String, dynamic>>> fetchGames() async {
    final dataSnapshot = await firestoreInstance.collection('Games').get();
    return dataSnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final user = authInstance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
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
                  child: SizedBox(),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                    color: Color.fromARGB(255, 203, 149, 212),
                  ),
                  child: IconButton(
                    onPressed: logoutUser,
                    icon: const Icon(Icons.logout),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: gamesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Fehler: ${snapshot.error}"));
                  }
                  final games = snapshot.data;

                  if (games == null || games.isEmpty) {
                    return const Center(child: Text("Keine Spiele gefunden."));
                  }

                  return ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];

                      return Card(
                        child: ListTile(
                          title: Text(
                            game['Game_name'] != null &&
                                    game['Game_name'].isNotEmpty
                                ? "${game['Game_name']}"
                                : "'Bober nix finden'",
                          ),
                          subtitle: Text(
                            game['Genre'] != null && game['Genre'].isNotEmpty
                                ? "Genre: ${game['Genre']}"
                                : "Genre: Bober nix finden",
                          ),
                          trailing: Text(
                            game['Funfactor'] != null &&
                                    game['Funfactor'].isNotEmpty
                                ? "Funfactor: ${game['Funfactor']}"
                                : "Funfactor: Nicht bewertet",
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
