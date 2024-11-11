import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/core/states/app_state.dart';
import 'package:tezda/features/product/domain/entities/product.dart';
import 'package:tezda/features/product/domain/usecases/get_product.dart';

class ProductNotifier extends StateNotifier<AppState<List<Product>>> {
  final GetProductUseCase getProductUseCase;

  ProductNotifier({required this.getProductUseCase}) : super(InitialAppState());

  Future<void> fetchProducts() async {
    state = LoadingAppState();

    final result = await getProductUseCase.call();

    state = result.fold(
      (failure) => FailureAppState(failure.message),
      (products) => SuccessAppState(data: products),
    );
  }

  // Reset state to initial
  void resetState() {
    state = InitialAppState();
  }
}
