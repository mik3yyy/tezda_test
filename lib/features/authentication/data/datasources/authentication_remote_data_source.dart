import 'package:dio/dio.dart';
import 'package:tezda/core/utils/typedef.dart';
import 'package:tezda/features/authentication/data/models/update_user_model.dart';
import 'package:tezda/features/authentication/domain/usecases/create_account.dart';

import '../../../../core/network/network.dart';

abstract class AuthenticationRemoteDataSource {
  Future<DataMap> login(String username, String password);
  Future<DataMap> signUp(CreateAccountParams params);

  Future<DataMap> getUser();

  Future<DataMap> updateUser({required UpdateUser updateUser});
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final Network _network;

  AuthenticationRemoteDataSourceImpl({required Network network})
      : _network = network;

  @override
  Future<DataMap> login(String username, String password) async {
    Response response = await _network.call(
      '/auth/login',
      RequestMethod.post,
      data: {
        "username": username,
        "password": password,
      },
    );
    print(response.data);
    return response.data;
  }

  @override
  Future<DataMap> signUp(CreateAccountParams params) async {
    Response response = await _network.call(
      '/users',
      RequestMethod.post,
      data: params.toJson(),
    );
    return response.data;
  }

  @override
  Future<DataMap> getUser() async {
    Response response = await _network.call(
      '/users/7',
      RequestMethod.get,
    );
    return response.data;
  }

  @override
  Future<DataMap> updateUser({required UpdateUser updateUser}) async {
    Response response = await _network.call('/users/7', RequestMethod.patch,
        data: updateUser.toJson());
    return response.data;
  }
}
