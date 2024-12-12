import 'dart:developer';

import 'package:flutter/material.dart';
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
                  flex: 4,
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Abmelden?"),
                            content: const Text("Wirkloich Abmelden?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Abbrechen"),
                              ),
                              TextButton(
                                onPressed: () {
                                  logoutUser();
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Ja"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                    color: Color.fromARGB(255, 203, 149, 212),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {
                      setState(
                        () {
                          gamesFuture = fetchGames();
                        },
                      );
                    },
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
