import 'package:bleumanager/util/credential.dart';
import 'package:bleumanager/object/bleu.dart';

class ServerConnector {
  static Future<bool> deleteBleu(Credential credential, Bleu bleu) async {

    return true;
  }

  static Future<bool> modifyBleu(Credential credential, Bleu bleu) async {

    return true;
  }

  static Future<List<Bleu>> fetchBleu(Credential credential) async {

    return [];
  }

  static Future<bool> checkAdmin(Credential credential) async {

    return true;
  }
}