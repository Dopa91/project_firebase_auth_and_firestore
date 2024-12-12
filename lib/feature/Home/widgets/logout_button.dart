import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    this.button,
  });

  final void Function()? button;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  const TextButton(
                    onPressed: null,
                    child: Text("Ja"),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }
}
