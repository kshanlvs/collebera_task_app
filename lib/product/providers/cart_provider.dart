import 'package:collebera_task_app/product/models/products_model.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Products> _cartList = [];

  List<Products> get cartList => _cartList;

  int get cartCount => _cartList.length;

  void addItemToCart(BuildContext context, Products product) {
    try {
      // Check if the product is already in the cart
      if (_cartList.any((item) => item.id == product.id)) {
        // If it is, show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} is already in the cart.'),
          ),
        );
      } else {
        _cartList.add(product);
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} added to cart.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add ${product.title} to cart: $e'),
        ),
      );
    }
  }

  void removeItemFromCart(Products product) {
    try {
      _cartList.removeWhere((item) => item.id == product.id);
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void increaseQuantity(Products product) {
    try {
      product.quantity = product.quantity + 1;
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void decreaseQuantity(Products product) {
    try {
      if (product.quantity > 1) {
        product.quantity = product.quantity - 1;
      } else {
        removeItemFromCart(product);
      }
      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  double getTotalPrice() {
    return _cartList.fold(
        0.0, (total, current) => total + (current.price! * current.quantity));
  }
}
