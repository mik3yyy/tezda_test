import 'package:tezda/core/utils/typedef.dart';
import 'package:tezda/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  ResultFuture<List<Product>> fetchProducts();
}
