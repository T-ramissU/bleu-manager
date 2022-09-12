import 'dart:convert';
import 'package:tuple/tuple.dart';
import 'package:http/http.dart' as http;

import 'package:bleumanager/util/credential.dart';
import 'package:bleumanager/object/bleu.dart';

const int _successCode = 200;
const int _unauthorizedCode = 401;
const int _badRequestCode = 400;
const String _serverUrl = "https://bleusaille.emixam.be";
const String _checkAdminUrl = "$_serverUrl/check_admin.php";
const String _fetchBleuUrl = "$_serverUrl/fetch.php";
const String _modifyBleuUrl = "$_serverUrl/modify.php";

/// Allow to exchange data with the server
class ServerConnector {
  /// Return 0 if success
  /// Return 1 if unauthorized
  /// Return 2 if bad request
  /// Return 3 if server error or otherwise
  static int _statusCodeToReturnInt(int statusCode) {
    switch(statusCode) {
      case _successCode:
        return 0;
      case _unauthorizedCode:
        return 1;
      case _badRequestCode:
        return 2;
      default:
        return 3;
    }
  }

  /// Update a bleu's attribute in the server
  ///
  /// The Json [key] must be the same attribute's name used by the server
  /// to identify the attribute. It will be updated with the [value]
  /// Return 0 if success
  /// Return 1 if the [credential] are not authorized on the server
  ///           or not defined
  /// Return 2 if the [key] or [value] are not valid
  /// Return 3 if error server or something else
  static Future<int> modifyBleu(
      Credential credential, String key, String value) async {
    if (credential.username == null || credential.password == null) return 1;

    var res = await http.post(Uri.parse(_modifyBleuUrl), body: {
      "matricule": credential.username,
      "token": credential.password,
      "key": key,
      key: value,
    });

    return _statusCodeToReturnInt(res.statusCode);
  }

  /// Fetch all bleu stored on the server
  ///
  /// Return a tuple which contain a list containing the fetched bleu
  /// and an integer equal to :
  /// 0 if success
  /// 1 if the [credential] are not authorized on the server
  ///   or not defined
  /// 3 if error server or something else
  static Future<Tuple2<List<Bleu>, int>> fetchBleu(Credential credential) async {
    if (credential.username == null || credential.password == null) {
      return const Tuple2([], 1);
    }

    var res = await http.post(Uri.parse(_fetchBleuUrl), body: {
      "matricule": credential.username,
      "token": credential.password,
    });

    List<Bleu> bleuList = [];
    for (dynamic bleuJson in json.decode(res.body)) {
      bleuList.add(Bleu.fromJson(bleuJson));
    }
    return Tuple2(bleuList, _statusCodeToReturnInt(res.statusCode));
  }

  /// Check if the credential are authorized by the server
  ///
  /// Return 0 if success
  /// Return 1 if the [credential] are not authorized on the server
  ///           or not defined
  /// Return 3 if error server or something else
  static Future<int> checkAdmin(Credential credential) async {
    if (credential.username == null || credential.password == null) return 1;

    var res = await http.post(Uri.parse(_checkAdminUrl), body: {
      "matricule": credential.username,
      "token": credential.password,
    });

    return _statusCodeToReturnInt(res.statusCode);
  }
}
