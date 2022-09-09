import 'package:flutter/material.dart';
import 'package:bleumanager/object/bleu.dart';
import 'package:bleumanager/widget/edit_page.dart';
class BleuPopup extends StatelessWidget {
  final Bleu _bleu;

  const BleuPopup(this._bleu, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${_bleu.lastname} ${_bleu.firstname}",
          textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:  [
          PopupMenuItem(child: Text("Details")),
          TextButton(child: Text("Modifier"),onPressed:()=>{
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditPage(_bleu)))
          }),
          PopupMenuItem(child: Text("Supprimer")),
        ],
      ),
    );
  }
}
