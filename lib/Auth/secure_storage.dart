import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class SecureStorage {
  //static IOSOptions options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  static FlutterSecureStorage _storage = FlutterSecureStorage();
  static String jwt_key = "jwt";
  static final options = IOSOptions(accessibility: KeychainAccessibility.first_unlock);



  // named constructor


  static Future<void> write(String value) async {
    await _storage.write(key: jwt_key, value: value, iOptions: options);
  }

  static Future<String?> read() async {
    return await _storage.read(key: jwt_key)?? "No data found";
  }

  static Future<void> empty() async {
    await _storage.deleteAll();
  }


// ... other wrapper methods as necessary
}
