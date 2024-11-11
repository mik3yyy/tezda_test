import 'package:tezda/core/usecases/usecase.dart';
import 'package:tezda/core/utils/typedef.dart';
import 'package:tezda/features/authentication/domain/entities/address.dart';
import 'package:tezda/features/authentication/domain/entities/name.dart';
import 'package:tezda/features/authentication/domain/repositories/authentication_repository.dart';

class CreateAccountUsecase
    extends UsecaseWithParams<void, CreateAccountParams> {
  final AuthenticationRepository _repository;

  CreateAccountUsecase({required AuthenticationRepository repository})
      : _repository = repository;

  @override
  ResultFuture<void> call(CreateAccountParams params) {
    return _repository.createAccount(
        createAccountParams: CreateAccountParams(
            email: params.email,
            username: params.username,
            password: params.password,
            name: params.name,
            address: params.address,
            phone: params.phone));
  }
}

class CreateAccountParams {
  final String email;
  final String username;
  final String password;
  final Name name;
  final Address address;
  final String phone;

  CreateAccountParams({
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  // Method to convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'name': name.toJson(),
      'address': address.toJson(),
      'phone': phone,
    };
  }
}
