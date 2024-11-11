import 'package:tezda/core/usecases/usecase.dart';
import 'package:tezda/core/utils/typedef.dart';
import 'package:tezda/features/authentication/domain/repositories/authentication_repository.dart';

class LoginUsecase extends UsecaseWithParams<void, LoginParams> {
  final AuthenticationRepository _repository;

  LoginUsecase({required AuthenticationRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(LoginParams params) {
    // TODO: implement call
    return _repository.login(
        login:
            LoginParams(userName: params.userName, password: params.password));
  }
}

class LoginParams {
  final String userName;
  final String password;

  LoginParams({required this.userName, required this.password});
}
