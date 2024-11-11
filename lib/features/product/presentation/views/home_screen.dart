import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tezda/core/extensions/widget_extensions.dart';
import 'package:tezda/core/routes/routes.dart';
import 'package:tezda/core/services/providers.dart';
import 'package:tezda/core/states/app_state.dart';
import 'package:tezda/core/widgets/custom_shimmer.dart';
import 'package:tezda/features/product/domain/entities/product.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final productState = ref.read(productNotifierProvider);

      // Only call fetchProducts if not already in SuccessAppState
      if (productState is! SuccessAppState<List<Product>>) {
        ref.read(productNotifierProvider.notifier).fetchProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Welcome!"),
      ),
      body: productState is LoadingAppState
          ? ComplexShimmer.listShimmer(itemCount: 10).withCustomPadding()
          : productState is FailureAppState
              ? Center(
                  child: Text(
                    'Error: ${productState.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : productState is SuccessAppState<List<Product>>
                  ? ListView.builder(
                      itemCount: productState.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final product = productState.data![index];
                        return ListTile(
                          onTap: () {
                            context.goNamed(Routes.productDetailName,
                                extra: product);
                          },
                          leading: CachedNetworkImage(
                            imageUrl: product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ).withHero("product${product.id}"),
                          title: Text(product.title),
                          subtitle:
                              Text('\$${product.price.toStringAsFixed(2)}'),
                        );
                      },
                    )
                  : const Center(child: Text('No products found')),
    );
  }
}
