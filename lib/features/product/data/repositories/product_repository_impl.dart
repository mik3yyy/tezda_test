import 'package:dartz/dartz.dart';
import 'package:tezda/core/error/failures.dart';
import 'package:tezda/core/network/network.dart';
import 'package:tezda/core/utils/typedef.dart';
import 'package:tezda/features/product/domain/entities/product.dart';

import '../datasources/product_remote_data_source.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  ResultFuture<List<Product>> fetchProducts() async {
    try {
      final products = await remoteDataSource.getProducts();
      return Right(products);
    } on ApiError catch (e) {
      return Left(ServerFailure(e.errorDescription));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
