import 'package:bleumanager/widget/bleu_popup.dart';
import 'package:bleumanager/util/server_connector.dart';
import 'package:bleumanager/util/credential.dart';
import 'package:flutter/material.dart';

class Bleu with ChangeNotifier {
  String _matricule;
  String _lastname;
  String _firstname;
  bool _supp;
  String _regio;
  String _tel;
  String _com;
  String _med;

  Bleu(this._matricule, this._lastname, this._firstname, this._supp,
      this._regio, this._tel, this._med, this._com);

  Bleu.fromJson(Map<String, dynamic> json)
      : _matricule = json["matricule"],
        _lastname = json["lastname"],
        _firstname = json["firstname"],
        _supp = json["supp"],
        _regio = json["regio"],
        _tel = json["tel"],
        _com = json["com"],
        _med = json["med"];

  Map<String, dynamic> toJson() => {
        "matricule": _matricule,
        "lastname": _lastname,
        "firstname": _firstname,
        "supp": _supp,
        "regio": _regio,
        "tel": _tel,
        "com": _com,
        "med": _med
      };

  String get matricule => _matricule;
  String get lastname => _lastname;
  String get firstname => _firstname;
  bool get supp => _supp;
  String get regio => _regio;
  String get tel => _tel;
  String get com => _com;
  String get med => _med;

  set matricule(String value) {
    _matricule = value;
    notifyListeners();
  }
  set lastname(String value) {
    _lastname = value;
    notifyListeners();
  }
  set firstname(String value) {
    _firstname = value;
    notifyListeners();
  }
  set supp(bool supp) {
    _supp = supp;
    notifyListeners();
  }
  set regio(String value) {
    _regio = value;
    notifyListeners();
  }
  set tel(String value) {
    _tel = value;
    notifyListeners();
  }
  set com(String value) {
    _com = value;
    notifyListeners();
  }
  set med(String value) {
    _med = value;
    notifyListeners();
  }
}

// Model which represents all [Bleu] objects
class BleuDataSource with ChangeNotifier {
  List<Bleu> _bleuRemaining = [];
  List<Bleu> _bleuDeleted = [];

  BleuDataSource() {
    _bleuRemaining = <Bleu>[
      Bleu("45", "TRuc", "machin", true, "Fronta", "4568566", "polente", "rien")
    ];
  }

  Future<void> fetch() async {
    List<Bleu> bleuList = await ServerConnector.fetchBleu(Credential());
    for (Bleu bleu in bleuList) {
      bleu.addListener(() => _updateBleu(bleu));
      bleu.supp ? _bleuDeleted.add(bleu) : _bleuRemaining.add(bleu);
    }
  }
  
  void _updateBleu(Bleu bleu){
    ServerConnector.modifyBleu(Credential(), bleu);
  }

  // Set [deleted] to true to sort deleted Bleu other it sort remaining Bleu
  void sort<T>(Comparable<T> Function(Bleu b) getField, bool ascending, {bool? deleted}) {
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
  List<DataRow> getData(BuildContext context, {bool? deleted}) {
    List<Bleu> list = deleted == null ? _bleuRemaining : _bleuDeleted;

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
