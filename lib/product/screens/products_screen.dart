import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductProvider>().fetchProducts(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: const Text('Hello, Andres'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      context.go("/cartScreen");
                    },
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${cartProvider.cartCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
      body: Consumer2<ProductProvider,CartProvider>(
        builder: (context, provider,cartProvider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  childAspectRatio:.5, // Aspect ratio of each card
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: provider.products.length,
                itemBuilder: (context, index) {
                  Products product = provider.products[index];
                  return InkWell(
                    onTap: () {
                      context.go('/productDetails', extra: {"product": product});
                    },
                    child: ProductCard(
                      onTapAddToCart: () {
                        cartProvider.addItemToCart(context,product);
                      },
                      imageUrl: product.image ?? "",
                      title: product.title ?? "NA",
                      description: product.description ?? "NA",
                      price: product.price ?? 0,
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
