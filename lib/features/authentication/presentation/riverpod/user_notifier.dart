import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/core/states/app_state.dart';
import 'package:tezda/features/authentication/data/models/update_user_model.dart';
import 'package:tezda/features/authentication/domain/entities/user.dart';
import 'package:tezda/features/authentication/domain/usecases/get_user.dart';
import 'package:tezda/features/authentication/domain/usecases/update_user.dart';

class UserNotifier extends StateNotifier<AppState<User>> {
  final GetUserUsecase getUserUsecase;
  final UpdateUserUseCase updateUserUsecase;

  UserNotifier({
    required this.getUserUsecase,
    required this.updateUserUsecase,
  }) : super(InitialAppState());

  // Fetch user details
  Future<void> fetchUserDetails() async {
    state = LoadingAppState();

    final result = await getUserUsecase();

    state = result.fold(
      (failure) => FailureAppState(failure.message),
      (user) => SuccessAppState(data: user),
    );
  }

  // Update user details
  Future<void> updateUser(UpdateUser updateUser) async {
    state = LoadingAppState();

    final result = await updateUserUsecase(updateUser);

    state = result.fold(
      (failure) => FailureAppState(failure.message),
      (updatedUser) => SuccessAppState(data: updatedUser),
    );
  }

  // Reset state to initial
  void resetState() {
    state = InitialAppState();
  }
}
