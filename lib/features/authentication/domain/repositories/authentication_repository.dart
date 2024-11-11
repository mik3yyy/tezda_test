import 'package:tezda/core/utils/typedef.dart';
import 'package:tezda/features/authentication/data/models/update_user_model.dart';
import 'package:tezda/features/authentication/domain/entities/user.dart';
import 'package:tezda/features/authentication/domain/usecases/create_account.dart';
import 'package:tezda/features/authentication/domain/usecases/login.dart';

abstract class AuthenticationRepository {
  ResultFuture<void> createAccount(
      {required CreateAccountParams createAccountParams});
  ResultFuture<void> login({required LoginParams login});

  ResultFuture<User> updateUser({required UpdateUser updateUser});

  ResultFuture<User> getUser();
}
