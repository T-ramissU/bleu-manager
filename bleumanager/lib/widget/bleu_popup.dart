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
      insetPadding: EdgeInsets.all(100),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      title: Text(
        "${_bleu.lastname} ${_bleu.firstname}",
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: const Text("Details",style: TextStyle(fontSize: 17)),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(_bleu),
              ),
            ),
          ),
          TextButton(
            child: const Text("Modifier",style: TextStyle(fontSize: 17),),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditPage(_bleu),
              ),
            ),
          ),
          TextButton(
            child: _deleteAction ? const Text("Supprimer",style: TextStyle(fontSize: 17)) : const Text("Restorer",style: TextStyle(fontSize: 17)),
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
