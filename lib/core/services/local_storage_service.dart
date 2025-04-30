import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: 'access_token');
  }
}
