import 'package:collebera_task_app/product/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:collebera_task_app/product/models/products_model.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Products product;

  const ProductDetailsScreen({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: FadeInImage.assetNetwork(
                placeholder:
                    "assets/images/placeholder-image.png", // Path to your placeholder image
                image: product.image ?? "",
                height: screenWidth * 0.6,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(
                    milliseconds:
                        500), // Optional: specify the fade-in duration
              )),
              const SizedBox(height: 16.0),
              Text(
                product.title ?? "",
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Divider(color: Colors.black),
              Text(
                product.description ?? "",
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(height: 16.0),
              Text(
                '\$${product.price?.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {
                      // Handle add to wishlist action
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: TextButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().addItemToCart(context, product);
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                    label: const Text(
                      "Add To Cart",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle checkout action
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
