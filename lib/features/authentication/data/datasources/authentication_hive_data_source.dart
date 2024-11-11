import 'package:hive_flutter/hive_flutter.dart';

abstract class AuthenticationHiveDataSource {
  Future<void> saveUser({required String userToken});
  Future<void> deleteUser();

  Future<bool> isLogin();
}

class AuthenticationHiveDataSourceImpl extends AuthenticationHiveDataSource {
  String key = 'userKey';
  final Box _box;

  AuthenticationHiveDataSourceImpl({required Box box}) : _box = box;

  @override
  Future<void> deleteUser() async {
    await _box.delete(key);
  }

  @override
  Future<void> saveUser({required String userToken}) async {
    await _box.put(key, userToken);
  }

  @override
  Future<bool> isLogin() async {
    return _box.get(key) != null;
  }
}
