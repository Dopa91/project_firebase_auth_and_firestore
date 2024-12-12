import 'package:flutter/material.dart';

class DownloadGameListButton extends StatelessWidget {
  const DownloadGameListButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        color: Color.fromARGB(255, 203, 149, 212),
      ),
      child: const IconButton(
        icon: Icon(Icons.download),
        onPressed: null,
      ),
    );
  }
}
