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
      throw Exception('Failed to remove ${product.title} from cart: $e');
    }
  }

  void increaseQuantity(Products product) {
    try {
      _updateProductQuantity(product, product.quantity + 1);
    } catch (e) {
      throw Exception('Failed to increase quantity for ${product.title}: $e');
    }
  }

  void decreaseQuantity(Products product) {
    try {
      if (product.quantity > 1) {
        _updateProductQuantity(product, product.quantity - 1);
      } else {
        removeItemFromCart(product);
      }
    } catch (e) {
      throw Exception('Failed to decrease quantity for ${product.title}: $e');
    }
  }

  void _updateProductQuantity(Products product, int newQuantity) {
    int index = _cartList.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _cartList[index] = _cartList[index].copyWith(quantity: newQuantity);
      notifyListeners();
    }
  }

  double getTotalPrice() {
    return _cartList.fold(
        0.0, (total, current) => total + (current.price * current.quantity));
  }
}
