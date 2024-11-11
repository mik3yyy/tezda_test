import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/core/states/app_state.dart';
import 'package:tezda/features/authentication/domain/usecases/create_account.dart';
import 'package:tezda/features/authentication/domain/usecases/login.dart';

class AuthNotifier extends StateNotifier<AppState<void>> {
  final LoginUsecase loginUsecase;
  final CreateAccountUsecase createAccountUsecase;

  AuthNotifier({required this.loginUsecase, required this.createAccountUsecase})
      : super(InitialAppState());

  Future<void> login(String username, String password) async {
    state = LoadingAppState();

    final result = await loginUsecase
        .call(LoginParams(userName: username, password: password));

    state = result.fold(
      (failure) => FailureAppState(failure.message),
      (user) => SuccessAppState(),
    );
  }

  Future<void> signup(CreateAccountParams params) async {
    state = LoadingAppState();

    final result = await createAccountUsecase.call(params);

    state = result.fold(
      (failure) => FailureAppState(failure.message),
      (_) => SuccessAppState(),
    );
  }

  // Reset state to initial
  void resetState() {
    state = InitialAppState();
  }
}
