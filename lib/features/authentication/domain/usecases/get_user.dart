import 'package:tezda/core/usecases/usecase.dart';
import 'package:tezda/core/utils/typedef.dart';
import 'package:tezda/features/authentication/domain/entities/user.dart';
import 'package:tezda/features/authentication/domain/repositories/authentication_repository.dart';

class GetUserUsecase extends UsecaseWithoutParams<User> {
  final AuthenticationRepository _repository;

  GetUserUsecase({required AuthenticationRepository repository})
      : _repository = repository;

  @override
  ResultFuture<User> call() {
    // TODO: implement call
    return _repository.getUser();
  }
}
