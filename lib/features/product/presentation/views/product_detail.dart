import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tezda/core/extensions/context_extensions.dart';
import 'package:tezda/core/extensions/widget_extensions.dart';
import 'package:tezda/core/services/providers.dart';
import 'package:tezda/core/widgets/custom_button.dart';
import 'package:tezda/features/product/domain/entities/product.dart';

class ProductDetail extends ConsumerStatefulWidget {
  const ProductDetail({super.key, required this.product});
  final Product product;

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail> {
  late bool isFavorite;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final favoriteService = ref.read(favoriteServiceProvider);
    isFavorite = favoriteService.isFavorite(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final favoriteService = ref.read(favoriteServiceProvider);
    isFavorite = favoriteService.isFavorite(product.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: CachedNetworkImage(
                imageUrl: product.image,
                height: 300,
                fit: BoxFit.cover,
              ).withHero("product${product.id}"),
            ),
            const SizedBox(height: 16),
            // Product Title
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            // Product Price
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(16),
            // Product Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                Text(
                    '${product.rating.rate} (${product.rating.count} reviews)'),
              ],
            ),
            Gap(16),
            // Product Description
            Text(
              'Description:',
              style: context.textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: context.textTheme.bodyMedium,
            ),
            Gap(16),
            // Product Category
            Row(
              children: [
                const Text(
                  'Category: ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  product.category,
                ),
              ],
            ),
            Gap(16),
            // Add to Cart Button
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 120,
        child: Row(
          children: [
            CustomButton(label: "Add to Cart", onPressed: () {}).withExpanded(),
            const Gap(10),
            IconButton(
              onPressed: () {
                if (isFavorite) {
                  setState(() {
                    favoriteService.removeFavorite(product.id);
                  });
                } else {
                  setState(() {
                    favoriteService.addFavorite(product);
                  });
                }
              },
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: context.colors.red),
              iconSize: 40,
            )
          ],
        ),
      ),
    );
  }
}
