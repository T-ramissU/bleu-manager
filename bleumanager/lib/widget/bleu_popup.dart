import 'package:flutter/material.dart';
import 'package:bleumanager/object/bleu.dart';

class BleuPopup extends StatelessWidget {
  final Bleu _bleu;
  const BleuPopup(this._bleu, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${_bleu.lastname} ${_bleu.firstname}", textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          PopupMenuItem(child: Text("Details")),
          PopupMenuItem(child: Text("Modifier")),
          PopupMenuItem(child: Text("Supprimer")),
        ],
      ),
    );
  }
}
