import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Singleton instance
// [matricule] represents the UMons admin matricule, null if not exists or not loaded
// [token] represents the admin personnal token, null if not exists or not loaded
// [exists] is set to true if [matricule] and [token] have been loaded,
//          otherwise if no credential exists, it is set to false.
//          It can be null if [Credential.load] has not been called yet
class Credential {
  final _storage = const FlutterSecureStorage();
  late String? matricule;
  late String? token;
  bool? exists;

  Credential._privateConstructor() {}
  static final Credential _instance = Credential._privateConstructor();
  factory Credential() => _instance;

  // Save credential and initialize the class attributes [this.matricule]
  // and [this.token]
  void save(String matricule, String token) {
      this.matricule = matricule;
      this.token = token;
      exists = true;
      _storage.write(key: "MATRICULE", value: matricule);
      _storage.write(key: "TOKEN", value: token);
  }

  // Initialize the class attributes [this.matricule] and [this.token]
  // with the credential previously saved.
  Future<void> load() async {
    matricule = await _storage.read(key: "MATRICULE");
    token = await _storage.read(key: "TOKEN");

    if (matricule != null && token != null) {
      exists = true;
    } else {
      exists = false;
    }
  }

  void delete() {
    _storage.delete(key: "MATRICULE");
    _storage.delete(key: "TOKEN");
    matricule = null;
    token = null;
    exists = false;
  }
}