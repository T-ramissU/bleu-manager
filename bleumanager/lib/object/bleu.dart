import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'package:bleumanager/widget/bleu_popup.dart';
import 'package:bleumanager/util/server_connector.dart';
import 'package:bleumanager/util/credential.dart';

class ChangeNotifierParametric<T> {
  List<void Function(T param)> listeners = [];

  void addListener(void Function(T param) callback) => listeners.add(callback);

  void notifyListeners(T arg) {
    for (dynamic listener in listeners) {
      listener(arg);
    }
  }
}

class BleuJsonKey {
  static const String matricule = "Matricule";
  static const String lastname = "Nom";
  static const String firstname = "Prenom";
  static const String del = "Supp";
  static const String regio = "Regio";
  static const String tel = "Tel";
  static const String com = "Com";
  static const String med = "Med";
}

class Bleu with ChangeNotifierParametric<String> {
  String _matricule;
  String _lastname;
  String _firstname;
  bool _del;
  String _regio;
  String _tel;
  String _com;
  String _med;

  Bleu(this._matricule, this._lastname, this._firstname, this._del, this._regio,
      this._tel, this._med, this._com);

  Bleu.fromJson(Map<String, dynamic> json)
      : _matricule = json[BleuJsonKey.matricule],
        _lastname = json[BleuJsonKey.lastname],
        _firstname = json[BleuJsonKey.firstname],
        _del = json[BleuJsonKey.del] == '1',
        _regio = json[BleuJsonKey.regio],
        _tel = json[BleuJsonKey.tel],
        _com = json[BleuJsonKey.com],
        _med = json[BleuJsonKey.med];

  Map<String, dynamic> toJson() => {
        BleuJsonKey.matricule: _matricule,
        BleuJsonKey.lastname: _lastname,
        BleuJsonKey.firstname: _firstname,
        BleuJsonKey.del: _del.toString(),
        BleuJsonKey.regio: _regio,
        BleuJsonKey.tel: _tel,
        BleuJsonKey.com: _com,
        BleuJsonKey.med: _med
      };

  String get matricule => _matricule;

  String get lastname => _lastname;

  String get firstname => _firstname;

  bool get del => _del;

  String get regio => _regio;

  String get tel => _tel;

  String get com => _com;

  String get med => _med;

  set matricule(String value) {
    _matricule = value;
    notifyListeners(BleuJsonKey.matricule);
  }

  set lastname(String value) {
    _lastname = value;
    notifyListeners(BleuJsonKey.lastname);
  }

  set firstname(String value) {
    _firstname = value;
    notifyListeners(BleuJsonKey.lastname);
  }

  set del(bool supp) {
    _del = supp;
    notifyListeners(BleuJsonKey.del);
  }

  set regio(String value) {
    _regio = value;
    notifyListeners(BleuJsonKey.regio);
  }

  set tel(String value) {
    _tel = value;
    notifyListeners(BleuJsonKey.tel);
  }

  set com(String value) {
    _com = value;
    notifyListeners(BleuJsonKey.com);
  }

  set med(String value) {
    _med = value;
    notifyListeners(BleuJsonKey.med);
  }
}

/// Model which represents all [Bleu] objects
class BleuDataSource with ChangeNotifier {
  final List<Bleu> _bleuRemaining = [];
  final List<Bleu> _bleuDeleted = [];

  /// Return an integer equal to :
  /// 0 if success
  /// 1 if the [credential] are not authorized on the server
  ///   or not defined
  /// 3 if error server or something else
  Future<int> fetch() async {
    Tuple2 res = await ServerConnector.fetchBleu(Credential());

    for (Bleu bleu in res.item1) {
      bleu.addListener(
          (String updatedJsonKey) => _updateBleu(bleu, updatedJsonKey));
      bleu.del ? _bleuDeleted.add(bleu) : _bleuRemaining.add(bleu);
    }

    return res.item1;
  }

  void _updateBleu(Bleu bleu, String updatedJsonKey) {
    String? value;
    switch (updatedJsonKey) {
      // determine the updated attribute
      case BleuJsonKey.matricule:
        value = bleu.matricule;
        break;
      case BleuJsonKey.lastname:
        value = bleu.lastname;
        break;
      case BleuJsonKey.firstname:
        value = bleu.firstname;
        break;
      case BleuJsonKey.del:
        {
          //place the bleu in the right list if bleu.del has been switched
          int i = _bleuRemaining.indexOf(bleu);
          if (i < 0 && !bleu.del) {
            //[bleu] is in the deleted list & del is false
            _bleuDeleted.removeAt(i);
            _bleuRemaining.add(bleu);
          } else if (i >= 0 && bleu.del) {
            //[bleu] is in the remaining list & del is true
            _bleuRemaining.removeAt(i);
            _bleuDeleted.add(bleu);
          }
          value = bleu.del.toString();
        }
        break;
      case BleuJsonKey.regio:
        value = bleu.regio;
        break;
      case BleuJsonKey.tel:
        value = bleu.tel;
        break;
      case BleuJsonKey.com:
        value = bleu.com;
        break;
      case BleuJsonKey.med:
        value = bleu.med;
    }
    if (value != null) {
      ServerConnector.modifyBleu(Credential(), updatedJsonKey, value);
    }
  }

  // Set [deleted] to true to sort deleted Bleu other it sort remaining Bleu
  void sort<T>(Comparable<T> Function(Bleu b) getField, bool ascending,
      {bool? deleted}) {
    List<Bleu> list = deleted == null ? _bleuRemaining : _bleuDeleted;
    list.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
  }

  // Set [deleted] to true to get deleted Bleu otherwise it return remaining Bleu
  List<DataRow> getData(BuildContext context, bool deleted) {
    List<Bleu> list = deleted ? _bleuDeleted : _bleuRemaining;

    List<DataRow> listBleu = <DataRow>[];
    for (Bleu bleu in list) {
      DataRow row = DataRow(
        onLongPress: () async {
          await showDialog(
              context: context,
              builder: (BuildContext context) => BleuPopup(bleu));
        },
        cells: [
          DataCell(Text(bleu.matricule)),
          DataCell(Text(bleu.firstname)),
          DataCell(Text(bleu.lastname)),
        ],
      );
      listBleu.add(row);
    }
    return listBleu;
  }
}
