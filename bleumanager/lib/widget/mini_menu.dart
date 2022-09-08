import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MiniMenu extends StatelessWidget {
  const MiniMenu();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PopupMenuItem(child: Text("Details")),
        PopupMenuItem(child: Text("Modifier")),
        PopupMenuItem(child: Text("Supprimer")),
      ],
    );
  }
}
