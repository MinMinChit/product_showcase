import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:product_showcase/services/storage/storage.dart';

class SecureStorage implements Storage {
  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<dynamic> readData(String key) async {
    dynamic value = await _secureStorage.read(key: key);
    return value;
  }

  @override
  Future deleteData({key}) async {
    if (key == null) {
      await _secureStorage.deleteAll();
    } else {
      await _secureStorage.delete(key: key);
    }
  }

  @override
  Future<void> saveData(String key, dynamic value) async {
    await _secureStorage.write(key: key, value: value.toString());
  }
}
