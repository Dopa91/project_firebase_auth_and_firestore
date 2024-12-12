import 'package:flutter/material.dart';

class DownloadGameListButton extends StatelessWidget {
  const DownloadGameListButton({
    super.key,
    required this.button,
  });

  final VoidCallback button;

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
        icon: const Icon(Icons.download),
        onPressed: button,
      ),
    );
  }
}
