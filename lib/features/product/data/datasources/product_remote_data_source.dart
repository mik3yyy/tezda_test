import 'package:dio/dio.dart';
import 'package:tezda/features/product/domain/entities/product.dart';

import '../../../../core/network/network.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProducts();
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  final Network _network;

  ProductRemoteDataSourceImpl({required Network network}) : _network = network;

  @override
  Future<List<Product>> getProducts() async {
    Response response = await _network.call(
      '/products',
      RequestMethod.get,
    );

    // Parse the response into a list of Product objects
    final products = (response.data as List)
        .map((product) => Product.fromJson(product))
        .toList();

    return products;
  }
}
