import 'package:bleumanager/util/credential.dart';
import 'package:bleumanager/util/server_connector.dart';
import 'package:bleumanager/widget/bleu_popup.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

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
  static const String lastname = "Nom";
  static const String firstname = "Prenom";
  static const String sexe = "Sexe";
  static const String age = "Age";
  static const String bd = "DateN";
  static const String loc = "Adresse";
  static const String del = "Supp";
  static const String regio = "Regio";
  static const String tel = "Tel";
  static const String com = "Com";
  static const String med = "Med";
  static const String resp = "RespLegal";
  static const String telresp = "NumRespLegal";
  static const String ram1 = "Ramasage1";
  static const String ram2 = "Ramassage2";
  static const String ram3 = "Ramassage3";
  static const String ram4 = " Ramassage4";
}

class Bleu with ChangeNotifierParametric<String> {
  String _lastname;
  String _firstname;
  String _sexe;
  bool _del;
  String _regio;
  String _tel;
  String _com;
  String _med;
  String _age;
  String _bd;
  String _loc;
  String _resp;
  String _telresp;
  String _ram1;
  String _ram2;
  String _ram3;
  String _ram4;

  Bleu(
      this._lastname,
      this._firstname,
      this._sexe,
      this._del,
      this._regio,
      this._tel,
      this._med,
      this._com,
      this._age,
      this._bd,
      this._loc,
      this._ram1,
      this._ram2,
      this._ram3,
      this._ram4,
      this._resp,
      this._telresp);

  Bleu.fromJson(Map<String, dynamic> json)
      : _lastname = json[BleuJsonKey.lastname],
        _firstname = json[BleuJsonKey.firstname],
        _sexe = json[BleuJsonKey.sexe],
        _del = json[BleuJsonKey.del] == '1',
        _regio = json[BleuJsonKey.regio],
        _tel = json[BleuJsonKey.tel],
        _com = json[BleuJsonKey.com],
        _med = json[BleuJsonKey.med],
        _age = json[BleuJsonKey.age],
        _bd = json[BleuJsonKey.bd],
        _loc = json[BleuJsonKey.loc],
        _ram1 = json[BleuJsonKey.ram1],
        _ram2 = json[BleuJsonKey.ram2],
        _ram3 = json[BleuJsonKey.ram3],
        _ram4 = json[BleuJsonKey.ram4],
        _resp = json[BleuJsonKey.resp],
        _telresp = json[BleuJsonKey.telresp];

  Map<String, dynamic> toJson() => {
        BleuJsonKey.lastname: _lastname,
        BleuJsonKey.firstname: _firstname,
        BleuJsonKey.sexe: _sexe,
        BleuJsonKey.del: _del.toString(),
        BleuJsonKey.regio: _regio,
        BleuJsonKey.tel: _tel,
        BleuJsonKey.com: _com,
        BleuJsonKey.med: _med,
        BleuJsonKey.age: _age,
        BleuJsonKey.bd: _bd,
        BleuJsonKey.loc: _loc,
        BleuJsonKey.ram1: _ram1,
        BleuJsonKey.ram2: _ram2,
        BleuJsonKey.ram3: _ram3,
        BleuJsonKey.ram4: _ram4,
        BleuJsonKey.resp: _resp,
        BleuJsonKey.telresp: _telresp,
      };

  String get lastname => _lastname;

  String get firstname => _firstname;

  String get sexe => _sexe;

  bool get del => _del;

  String get regio => _regio;

  String get tel => _tel;

  String get com => _com;

  String get med => _med;

  String get age => _age;

  String get loc => _loc;

  String get bd => _bd;

  String get ram1 => _ram1;

  String get ram2 => _ram2;

  String get ram3 => _ram3;

  String get ram4 => _ram4;

  String get resp => _resp;

  String get telresp => _telresp;

  set lastname(String value) {
    _lastname = value;
    notifyListeners(BleuJsonKey.lastname);
  }

  set firstname(String value) {
    _firstname = value;
    notifyListeners(BleuJsonKey.lastname);
  }

  set sexe(String value) {
    _sexe = value;
    notifyListeners(BleuJsonKey.sexe);
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

  set age(String value) {
    _age = value;
    notifyListeners(BleuJsonKey.age);
  }

  set loc(String value) {
    _loc = value;
    notifyListeners(BleuJsonKey.loc);
  }

  set bd(String value) {
    _bd = value;
    notifyListeners(BleuJsonKey.bd);
  }

  set resp(String value) {
    _resp = value;
    notifyListeners(BleuJsonKey.resp);
  }

  set telresp(String value) {
    _telresp = value;
    notifyListeners(BleuJsonKey.telresp);
  }

  set ram1(String value) {
    _ram1 = value;
    notifyListeners(BleuJsonKey.ram1);
  }

  set ram2(String value) {
    _ram2 = value;
    notifyListeners(BleuJsonKey.ram2);
  }

  set ram3(String value) {
    _ram3 = value;
    notifyListeners(BleuJsonKey.ram3);
  }

  set ram4(String value) {
    _ram4 = value;
    notifyListeners(BleuJsonKey.ram4);
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

      case BleuJsonKey.lastname:
        value = bleu.lastname;
        break;
      case BleuJsonKey.firstname:
        value = bleu.firstname;
        break;
      case BleuJsonKey.sexe:
        value = bleu.sexe;
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
        break;
      case BleuJsonKey.age:
        value = bleu.age;
        break;
      case BleuJsonKey.bd:
        value = bleu.bd;
        break;
      case BleuJsonKey.loc:
        value = bleu.loc;
        break;
      case BleuJsonKey.resp:
        value = bleu.resp;
        break;
      case BleuJsonKey.telresp:
        value = bleu.telresp;
        break;
      case BleuJsonKey.ram1:
        value = bleu.ram1;
        break;
      case BleuJsonKey.ram2:
        value = bleu.ram2;
        break;
      case BleuJsonKey.ram3:
        value = bleu.ram3;
        break;
      case BleuJsonKey.ram4:
        value = bleu.ram4;
        break;
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
          DataCell(Text(bleu.firstname)),
          DataCell(Text(bleu.lastname)),
        ],
      );
      listBleu.add(row);
    }
    return listBleu;
  }
}
