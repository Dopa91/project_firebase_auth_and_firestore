import 'package:flutter/material.dart';

class GameListCard extends StatelessWidget {
  const GameListCard({
    super.key,
    required this.gamesFuture,
  });

  final Future<List<Map<String, dynamic>>>? gamesFuture;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                    game['Game_name'] != null && game['Game_name'].isNotEmpty
                        ? "${game['Game_name']}"
                        : "'Bober nix finden'",
                  ),
                  subtitle: Text(
                    game['Genre'] != null && game['Genre'].isNotEmpty
                        ? "Genre: ${game['Genre']}"
                        : "Genre: Bober nix finden",
                  ),
                  trailing: Text(
                    game['Funfactor'] != null && game['Funfactor'].isNotEmpty
                        ? "Funfactor: ${game['Funfactor']}"
                        : "Funfactor: Nicht bewertet",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
