import 'package:dartz/dartz.dart';
import 'package:tezda/core/error/failures.dart';
import 'package:tezda/core/network/network.dart';
import 'package:tezda/core/utils/typedef.dart';
import 'package:tezda/features/authentication/data/models/update_user_model.dart';

import 'package:tezda/features/authentication/domain/entities/user.dart';
import 'package:tezda/features/authentication/domain/usecases/create_account.dart';

import 'package:tezda/features/authentication/domain/usecases/login.dart';

import '../datasources/authentication_hive_data_source.dart';
import '../datasources/authentication_remote_data_source.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationHiveDataSource hiveDataSource;
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({
    required this.hiveDataSource,
    required this.remoteDataSource,
  });

  @override
  ResultFuture<void> login({required LoginParams login}) async {
    try {
      final data = await remoteDataSource.login(login.userName, login.password);
      hiveDataSource.saveUser(userToken: data['token']);
      return const Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<void> createAccount(
      {required CreateAccountParams createAccountParams}) async {
    try {
      await remoteDataSource.signUp(createAccountParams);
      return const Right(null);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<User> getUser() async {
    try {
      final data = await remoteDataSource.getUser();
      final user = User.fromJson(data);
      return Right(user);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }

  @override
  ResultFuture<User> updateUser({required UpdateUser updateUser}) async {
    try {
      final data = await remoteDataSource.updateUser(updateUser: updateUser);
      final updatedUser = User.fromJson(data);
      return Right(updatedUser);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    }
  }
}
