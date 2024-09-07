import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static String? token;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> writeData(String key, String value) async {
    await storage.write(key: key, value: value);
    token = await storage.read(key: key);
  }

  Future<bool> readData(String s) async {
    token = await storage.read(key: "token");
    return token != null;
  }

  Future<String> readToken(String s) async {
    String? token = await storage.read(key: 'token');
    return token!;
  }

  Future<void> deleteData(String key) async {
    await storage.delete(key: key);
  }
}
