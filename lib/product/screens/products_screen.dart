import 'package:collebera_task_app/routes_names.dart';
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
      appBar: _buildAppBar(context),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .5,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: productProvider.products.length,
                itemBuilder: (context, index) {
                  Products product = productProvider.products[index];
                  return InkWell(
                    onTap: () {
                      context
                          .go(RouteNames.productDetailScreen, extra: {"product": product});
                    },
                    child: ProductCard(
                      onTapAddToCart: () {
                        context
                            .read<CartProvider>()
                            .addItemToCart(context, product);
                      },
                      imageUrl: product.image,
                      title: product.title,
                      description: product.description,
                      price: product.price,
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

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text.rich(
        TextSpan(children: [
          TextSpan(text: "Hello,", style: TextStyle(fontSize: 16)),
          TextSpan(
              text: " Kishan", style: TextStyle(color: Colors.orangeAccent))
        ]),
      ),
      actions: [
        _buildCartIcon(context),
      ],
    );
  }

  Widget _buildCartIcon(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                context.go(RouteNames.cartScreen);
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
    );
  }
}
