import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bleumanager/util/credential.dart';
import 'package:bleumanager/object/bleu.dart';

const int _successCode = 200;
const String _serverUrl = "https://bleusaille.emixam.be";
const String _checkAdminUrl = "$_serverUrl/check_admin.php";
const String _fetchBleuUrl = "$_serverUrl/fetch.php";
const String _deleteBleuUrl = "$_serverUrl/delete.php";

class ServerConnector {
  static Future<bool> modifyBleu(
      Credential credential, String key, String value) async {
    if (credential.exists != true) return false;

    var res = await http.post(Uri.parse(_deleteBleuUrl), body: {
      "matricule": credential.matricule,
      "token": credential.token,
      "key": key,
      key: value,
    });

    return res.statusCode == _successCode;
  }

  static Future<List<Bleu>> fetchBleu(Credential credential) async {
    if (credential.exists != true) return [];

    var res = await http.post(Uri.parse(_fetchBleuUrl), body: {
      "matricule": credential.matricule,
      "token": credential.token,
    });

    return []; // TODO supp qd le server sera fait
    List<Bleu> bleuList = [];
    for (dynamic bleuJson in json.decode(res.body)) {
      bleuList.add(Bleu.fromJson(bleuJson));
    }
    return bleuList;
  }

  static Future<bool> checkAdmin(Credential credential) async {
    if (credential.exists != true) return false;

    var res = await http.post(Uri.parse(_checkAdminUrl), body: {
      "matricule": credential.matricule,
      "token": credential.token,
    });

    return true; // TODO supp qd le server sera fait
    return res.statusCode == _successCode;
  }
}
