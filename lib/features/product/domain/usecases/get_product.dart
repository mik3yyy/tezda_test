import 'package:tezda/core/usecases/usecase.dart';
import 'package:tezda/core/utils/typedef.dart';
import 'package:tezda/features/product/domain/entities/product.dart';
import 'package:tezda/features/product/domain/repositories/product_repository.dart';

class GetProductUseCase extends UsecaseWithoutParams<List<Product>> {
  final ProductRepository _repository;

  GetProductUseCase({required ProductRepository repository})
      : _repository = repository;

  @override
  ResultFuture<List<Product>> call() {
    return _repository.fetchProducts();
  }
}
