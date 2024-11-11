import 'package:hive_flutter/hive_flutter.dart';
import 'package:tezda/features/product/domain/entities/product.dart';

import 'package:hive/hive.dart';

class FavoriteService {
  final Box<Map> favoriteBox;

  FavoriteService({required this.favoriteBox});

  // Add a product to favorites
  Future<void> addFavorite(Product product) async {
    if (!isFavorite(product.id)) {
      await favoriteBox.put(product.id.toString(), product.toJson());
    }
  }

  // Remove a product from favorites
  Future<void> removeFavorite(int productId) async {
    await favoriteBox.delete(productId.toString());
  }

  // Check if a product is in favorites
  bool isFavorite(int productId) {
    return favoriteBox.containsKey(productId.toString());
  }

  // Get all favorite products
  List<Product> getFavorites() {
    return favoriteBox.values.map((e) {
      return Product.fromJson(e as Map<dynamic, dynamic>);
    }).toList();
  }
}
