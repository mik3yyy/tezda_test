import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tezda/core/network/network.dart';
import 'package:tezda/features/authentication/data/datasources/authentication_hive_data_source.dart';
import 'package:tezda/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tezda/features/authentication/domain/entities/user.dart';
import 'package:tezda/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:tezda/features/authentication/domain/usecases/create_account.dart';
import 'package:tezda/features/authentication/domain/usecases/get_user.dart';
import 'package:tezda/features/authentication/domain/usecases/login.dart';
import 'package:tezda/features/authentication/domain/usecases/update_user.dart';
import 'package:tezda/features/authentication/presentation/riverpod/auth_notifer.dart';
import 'package:tezda/features/authentication/presentation/riverpod/user_notifier.dart';
import 'package:tezda/features/product/data/datasources/product_remote_data_source.dart';
import 'package:tezda/features/product/data/repositories/product_repository_impl.dart';
import 'package:tezda/features/product/domain/repositories/product_repository.dart';
import 'package:tezda/features/product/domain/usecases/get_product.dart';
import 'package:tezda/features/product/presentation/riverpod/favourite_service.dart';
import 'package:tezda/features/product/presentation/riverpod/get_product_state.dart';
import '../../features/authentication/data/datasources/authentication_remote_data_source.dart';
import '../states/app_state.dart';

final authRemoteDataSourceProvider =
    Provider<AuthenticationRemoteDataSource>((ref) {
  return AuthenticationRemoteDataSourceImpl(network: ref.read(networkProvider));
});
final box = Hive.box('userBox');

final authenticationHiveDataSourceProvider =
    Provider<AuthenticationHiveDataSource>((ref) {
  return AuthenticationHiveDataSourceImpl(box: box);
});

final authRepositoryProvider = Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepositoryImpl(
      remoteDataSource: ref.read(authRemoteDataSourceProvider),
      hiveDataSource: ref.read(authenticationHiveDataSourceProvider));
});

final networkProvider = Provider((ref) {
  return Network();
});

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AppState<void>>((ref) {
  return AuthNotifier(
      loginUsecase: ref.read(loginUsecaseProvider),
      createAccountUsecase: ref.read(createAccountUsecaseprovider));
});
final productNotifierProvider =
    StateNotifierProvider<ProductNotifier, AppState<void>>((ref) {
  return ProductNotifier(
    getProductUseCase: ref.read(getProductUseCaseProvider),
  );
});
final loginUsecaseProvider = Provider((ref) {
  return LoginUsecase(repository: ref.read(authRepositoryProvider));
});

final getProductUseCaseProvider = Provider((ref) {
  return GetProductUseCase(repository: ref.read(productRepositoryProvider));
});

final createAccountUsecaseprovider = Provider((ref) {
  return CreateAccountUsecase(repository: ref.read(authRepositoryProvider));
});

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>(
  (ref) => ProductRemoteDataSourceImpl(network: ref.read(networkProvider)),
);

final productRepositoryProvider = Provider<ProductRepository>(
  (ref) => ProductRepositoryImpl(
    remoteDataSource: ref.read(productRemoteDataSourceProvider),
  ),
);
final favoriteServiceProvider = Provider<FavoriteService>((ref) {
  final box = Hive.box<Map>('favorites');
  return FavoriteService(favoriteBox: box);
});
final userNotifierProvider =
    StateNotifierProvider<UserNotifier, AppState<User>>((ref) {
  return UserNotifier(
      getUserUsecase: ref.read(getUserUsecaseProvider),
      updateUserUsecase: ref.read(updateUserUsecaseProvider));
});

final getUserUsecaseProvider = Provider((ref) {
  return GetUserUsecase(repository: ref.read(authRepositoryProvider));
});

final updateUserUsecaseProvider = Provider((ref) {
  return UpdateUserUseCase(repository: ref.read(authRepositoryProvider));
});
