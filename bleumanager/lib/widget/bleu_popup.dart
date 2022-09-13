import 'package:flutter/material.dart';

import 'package:bleumanager/object/bleu.dart';
import 'package:bleumanager/widget/edit_page.dart';
import 'package:bleumanager/widget/details_page.dart';

/// Show the possible actions to perform on a bleu object :
/// show its [DetailPage], show its [EditPage], or delete/restore it
class BleuPopup extends StatelessWidget {
  final Bleu _bleu;
  final bool _deleteAction;

  /// [_bleu] concerned by the actions menu
  /// 
  /// Set [_deleteAction] to true to show delete action
  /// otherwise the restore display the restore action
  const BleuPopup(this._bleu, this._deleteAction, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "${_bleu.lastname} ${_bleu.firstname}",
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: const Text("Modifier"),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(_bleu),
              ),
            ),
          ),
          TextButton(
            child: const Text("Modifier"),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditPage(_bleu),
              ),
            ),
          ),
          TextButton(
            child: _deleteAction ? const Text("Supprimer") : const Text("Restorer"),
            onPressed: () {
              _bleu.del = _deleteAction;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
