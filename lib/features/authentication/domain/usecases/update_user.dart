import 'package:tezda/core/usecases/usecase.dart';
import 'package:tezda/core/utils/typedef.dart';
import 'package:tezda/features/authentication/data/models/update_user_model.dart';
import 'package:tezda/features/authentication/domain/entities/user.dart';
import 'package:tezda/features/authentication/domain/repositories/authentication_repository.dart';

class UpdateUserUseCase extends UsecaseWithParams<User, UpdateUser> {
  final AuthenticationRepository _repository;

  UpdateUserUseCase({required AuthenticationRepository repository})
      : _repository = repository;

  @override
  ResultFuture<User> call(UpdateUser updateUser) {
    return _repository.updateUser(updateUser: updateUser);
  }
}
