import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tezda/core/routes/routes.dart';
import 'package:tezda/core/services/providers.dart';
import 'package:tezda/features/product/domain/entities/product.dart';
import 'package:tezda/core/extensions/widget_extensions.dart';

class FavouriteScreen extends ConsumerStatefulWidget {
  const FavouriteScreen({super.key});

  @override
  ConsumerState<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends ConsumerState<FavouriteScreen> {
  late List<Product> favorites;

  @override
  void initState() {
    super.initState();
    final favoriteService = ref.read(favoriteServiceProvider);
    favorites =
        favoriteService.getFavorites(); // Retrieve the list of favorites
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ).withHero("product${product.id}"),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  onTap: () {
                    context.goNamed(Routes.productDetailFName, extra: product);
                  },
                );
              },
            ),
    );
  }
}
