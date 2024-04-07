import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static const _tokenKey = 'token';

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);
    return token;
  }

  Future<void> setToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
