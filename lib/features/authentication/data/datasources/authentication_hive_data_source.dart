import 'package:hive_flutter/hive_flutter.dart';

abstract class AuthenticationHiveDataSource {
  Future<void> saveUser({required String userToken});
  Future<void> deleteUser();

  Future<bool> isLogin();
}

class AuthenticationHiveDataSourceImpl extends AuthenticationHiveDataSource {
  String key = 'userKey';
  String expiryKey = 'tokenExpiry';

  final Box _box;

  AuthenticationHiveDataSourceImpl({required Box box}) : _box = box;

  @override
  Future<void> deleteUser() async {
    await _box.delete(expiryKey);
    await _box.delete(key);
  }

  @override
  Future<void> saveUser({required String userToken}) async {
    const sessionDuration = Duration(hours: 1);
    final expiryTime = DateTime.now().add(sessionDuration).toIso8601String();
    await _box.put(expiryKey, expiryTime);

    await _box.put(key, userToken);
  }

  @override
  Future<bool> isLogin() async {
    final token = _box.get(key);
    final expiryTimeString = _box.get(expiryKey);

    if (token == null || expiryTimeString == null) {
      return false; // User is not logged in
    }

    final expiryTime = DateTime.parse(expiryTimeString);

    if (DateTime.now().isAfter(expiryTime)) {
      await deleteUser(); // Token has expired, clean up
      return false;
    }

    return true; // User is logged in, and token is valid
  }
}
