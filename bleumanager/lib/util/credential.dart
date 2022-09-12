import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Singleton instance which allow to store username/password
class Credential {
  final _storage = const FlutterSecureStorage();

  /// Username, null if [Credential.load] has not yet been called
  /// or if no username exists
  late String? username;

  /// Password, null if [Credential.load] has not yet been called
  /// or if no username exists
  late String? password;

  Credential._privateConstructor();
  static final Credential _instance = Credential._privateConstructor();

  factory Credential() => _instance;

  /// Save credential and set [username] and [password]
  void save(String matricule, String token) {
    username = matricule;
    password = token;
    _storage.write(key: "MATRICULE", value: matricule);
    _storage.write(key: "TOKEN", value: token);
  }

  /// Initialize [username] and [password] with the values previously saved
  /// Return false if no credential are stored
  Future<bool> load() async {
    username = await _storage.read(key: "MATRICULE");
    password = await _storage.read(key: "TOKEN");
    return username != null && password != null;
  }

  /// Delete the saved [username] and [password] and set them to null
  void delete() {
    _storage.delete(key: "MATRICULE");
    _storage.delete(key: "TOKEN");
    username = null;
    password = null;
  }
}
