import 'package:bleumanager/util/credential.dart';
import 'package:bleumanager/util/server_connector.dart';
import 'package:bleumanager/widget/bleu_popup.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

/// Inerith of this class allow to add listenner on the object
/// The difference with [ChangeNotifier] is that a parameter of type [T] can
/// be passed by the notifier to the listener.
class ChangeNotifierParametric<T> {
  final List<void Function(T param)> _listeners = [];

  /// Add a listener
  void addListener(void Function(T param) callback) => _listeners.add(callback);

  /// Notify all listeners
  void notifyListeners(T arg) {
    for (dynamic listener in _listeners) {
      listener(arg);
    }
  }

  /// Return true if the listener has been removed, false if it does not exists
  bool removeListener(void Function(T param) callback) =>
      _listeners.remove(callback);
}

/// Contains all regio name recognized by the server
const List<String> bleuAllRegio = ["carolo", "fronta", "centrale", "boraine"];

/// Contains all Json key used by the server to identify the bleu's attributes.
/// Allow to translate the attribute name used in [Bleu] with the one used on the server
class _BleuJsonKey {
  static const String lastname = "Nom";
  static const String firstname = "Prenom";
  static const String sexe = "Sexe";
  static const String bd = "DateN";
  static const String loc = "Adresse";
  static const String del = "Supp";
  static const String regio = "Regio";
  static const String tel = "Tel";
  static const String com = "Com";
  static const String med = "Med";
  static const String resp = "RespLegal";
  static const String telresp = "NumRespLegal";
  static const String ram1 = "Ramassage1";
  static const String ram2 = "Ramassage2";
  static const String ram3 = "Ramassage3";
  static const String ram4 = "Ramassage4";
}

/// Represents a bleu
class Bleu with ChangeNotifierParametric<String> {
  String _lastname;
  String _firstname;
  String _sexe;
  bool _del;
  String _regio;
  String _tel;
  String _com;
  String _med;
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
      this._bd,
      this._loc,
      this._ram1,
      this._ram2,
      this._ram3,
      this._ram4,
      this._resp,
      this._telresp);

  /// Convert a json object where the keys are the static attribute of the class [_BleuJsonKey],
  /// to a [Bleu] object
  Bleu.fromJson(Map<String, dynamic> json)
      : _lastname = json[_BleuJsonKey.lastname],
        _firstname = json[_BleuJsonKey.firstname],
        _sexe = json[_BleuJsonKey.sexe],
        _del = json[_BleuJsonKey.del] == '1',
        _regio = json[_BleuJsonKey.regio],
        _tel = json[_BleuJsonKey.tel],
        _com = json[_BleuJsonKey.com],
        _med = json[_BleuJsonKey.med],
        _bd = json[_BleuJsonKey.bd],
        _loc = json[_BleuJsonKey.loc],
        _ram1 = json[_BleuJsonKey.ram1],
        _ram2 = json[_BleuJsonKey.ram2],
        _ram3 = json[_BleuJsonKey.ram3],
        _ram4 = json[_BleuJsonKey.ram4],
        _resp = json[_BleuJsonKey.resp],
        _telresp = json[_BleuJsonKey.telresp];

  /// Convert a [Bleu] object, to a json object where the keys
  /// are the static attribute of the class [_BleuJsonKey]
  Map<String, dynamic> toJson() => {
        _BleuJsonKey.lastname: _lastname,
        _BleuJsonKey.firstname: _firstname,
        _BleuJsonKey.sexe: _sexe,
        _BleuJsonKey.del: _del.toString(),
        _BleuJsonKey.regio: _regio,
        _BleuJsonKey.tel: _tel,
        _BleuJsonKey.com: _com,
        _BleuJsonKey.med: _med,
        _BleuJsonKey.bd: _bd,
        _BleuJsonKey.loc: _loc,
        _BleuJsonKey.ram1: _ram1,
        _BleuJsonKey.ram2: _ram2,
        _BleuJsonKey.ram3: _ram3,
        _BleuJsonKey.ram4: _ram4,
        _BleuJsonKey.resp: _resp,
        _BleuJsonKey.telresp: _telresp,
      };

  String get lastname => _lastname;

  set lastname(String value) {
    _lastname = value;
    notifyListeners(_BleuJsonKey.lastname);
  }

  String get firstname => _firstname;

  set firstname(String value) {
    _firstname = value;
    notifyListeners(_BleuJsonKey.firstname);
  }

  String get sexe => _sexe;

  set sexe(String value) {
    _sexe = value;
    notifyListeners(_BleuJsonKey.sexe);
  }

  bool get del => _del;

  set del(bool value) {
    _del = value;
    notifyListeners(_BleuJsonKey.del);
  }

  String get regio => _regio;

  /// Throw [Exception] in case of non accepted [value]
  /// The list of valid [value] are in given by [allBleuRegio]
  set regio(String value) {
    if (!bleuAllRegio.contains(value)) {
      throw Exception();
    }
    _regio = value;
    notifyListeners(_BleuJsonKey.regio);
  }

  String get tel => _tel;

  set tel(String value) {
    _tel = value;
    notifyListeners(_BleuJsonKey.tel);
  }

  String get com => _com;

  set com(String value) {
    _com = value;
    notifyListeners(_BleuJsonKey.com);
  }

  String get med => _med;

  set med(String value) {
    _med = value;
    notifyListeners(_BleuJsonKey.med);
  }

  String get loc => _loc;

  set loc(String value) {
    _loc = value;
    notifyListeners(_BleuJsonKey.loc);
  }

  String get bd => _bd;

  set bd(String value) {
    _bd = value;
    notifyListeners(_BleuJsonKey.bd);
  }

  String get ram1 => _ram1;

  set ram1(String value) {
    _ram1 = value;
    notifyListeners(_BleuJsonKey.ram1);
  }

  String get ram2 => _ram2;

  set ram2(String value) {
    _ram2 = value;
    notifyListeners(_BleuJsonKey.ram2);
  }

  String get ram3 => _ram3;

  set ram3(String value) {
    _ram3 = value;
    notifyListeners(_BleuJsonKey.ram3);
  }

  String get ram4 => _ram4;

  set ram4(String value) {
    _ram4 = value;
    notifyListeners(_BleuJsonKey.ram4);
  }

  String get resp => _resp;

  set resp(String value) {
    _resp = value;
    notifyListeners(_BleuJsonKey.resp);
  }

  String get telresp => _telresp;

  set telresp(String value) {
    _telresp = value;
    notifyListeners(_BleuJsonKey.telresp);
  }
}

/// Model which represents all [Bleu] objects
class BleuDataSource with ChangeNotifier {
  List<Bleu> _bleuRemaining = [];
  List<Bleu> _bleuDeleted = [];

  /// Return an integer equal to :
  /// 0 if success
  /// 1 if the [credential] are not authorized on the server
  ///   or not defined
  /// 3 if error server or something else
  Future<int> fetch() async {
    Tuple2 res = await ServerConnector.fetchBleu(Credential());

    _bleuRemaining = [];
    _bleuDeleted = [];

    for (Bleu bleu in res.item1) {
      // When the [bleu] is modified, the notifier send the updated attribute as a [updatedJsonKey] string,
      // which correspond to a static attribute of the class [BleuJsonKey]
      // which is propoagated to the function [_updateBleu] in order to update the
      // corresponding [bleu] on the server
      bleu.addListener(
          (String updatedJsonKey) => _updateBleu(bleu, updatedJsonKey));
      bleu.del ? _bleuDeleted.add(bleu) : _bleuRemaining.add(bleu);
    }

    return res.item2;
  }

  /// Callback fonction triggered when a [Bleu] object is modified
  /// in order to update the [bleu] on the server. Using the
  /// [updatedJsonKey] string (given by the class [_BleuJsonKey])
  /// to identify the attribute updated
  /// Errors are ignored (client side and server side)
  void _updateBleu(Bleu bleu, String updatedJsonKey) {
    String? value;
    // determine the updated attribute
    switch (updatedJsonKey) {
      case _BleuJsonKey.lastname:
        value = bleu.lastname;
        break;
      case _BleuJsonKey.firstname:
        value = bleu.firstname;
        break;
      case _BleuJsonKey.sexe:
        value = bleu.sexe;
        break;
      case _BleuJsonKey.del:
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
      case _BleuJsonKey.regio:
        value = bleu.regio;
        break;
      case _BleuJsonKey.tel:
        value = bleu.tel;
        break;
      case _BleuJsonKey.com:
        value = bleu.com;
        break;
      case _BleuJsonKey.med:
        value = bleu.med;
        break;
      case _BleuJsonKey.bd:
        value = bleu.bd;
        break;
      case _BleuJsonKey.loc:
        value = bleu.loc;
        break;
      case _BleuJsonKey.resp:
        value = bleu.resp;
        break;
      case _BleuJsonKey.telresp:
        value = bleu.telresp;
        break;
      case _BleuJsonKey.ram1:
        value = bleu.ram1;
        break;
      case _BleuJsonKey.ram2:
        value = bleu.ram2;
        break;
      case _BleuJsonKey.ram3:
        value = bleu.ram3;
        break;
      case _BleuJsonKey.ram4:
        value = bleu.ram4;
        break;
    }
    if (value != null) {
      ServerConnector.modifyBleu(Credential(), updatedJsonKey, value,
          bleu.lastname, bleu.firstname); // update it on the server
    }
  }

  /// Sort bleu
  ///
  /// Set [deleted] to true to sort deleted all bleu, otherwise it sort all remainig bleu
  /// [ascending] determines if the sort is in ascending or descending order
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

  /// Return all bleu as a [List] of [DataRow] where each [DataCell] of the row is the [Text] value of a bleu's attribute
  /// The cells order is the following :  [Bleu.lastname], [Bleu.firstname], [Bleu.sexe],
  /// [Bleu.regio], [Bleu.tel], [Bleu.com], [Bleu.med], [Bleu.bd], [Bleu.loc], [Bleu.resp],
  /// [Bleu.telresp], [Bleu.ram1], [Bleu.ram2], [Bleu.ram3], [Bleu.ram4]
  ///
  /// Set [deleted] to true to get all deleted bleu otherwise it return all remaining bleu
  List<DataRow> getData(void Function(void Function()) setState,
      BuildContext context, bool deleted) {
    List<Bleu> list = deleted ? _bleuDeleted : _bleuRemaining;

    List<DataRow> listBleu = <DataRow>[];
    for (Bleu bleu in list) {
      DataRow row = DataRow(
        onLongPress: () {
          // update list on return
          setState(
            () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      BleuPopup(bleu, !bleu.del));
            },
          );
        },
        cells: [
          DataCell(Text(bleu.firstname)),
          DataCell(Text(bleu.lastname)),
          DataCell(Text(bleu.regio)),
        ],
      );
      listBleu.add(row);
    }
    return listBleu;
  }
}
