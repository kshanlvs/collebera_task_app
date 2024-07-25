import 'package:collebera_task_app/product/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class CartProvider extends ChangeNotifier {
  final List<Products> _cartList = [];

  List<Products> get cartList => _cartList;

  int get cartCount => _cartList.length;

  void addItemToCart(BuildContext context, Products product) {
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
  }

  void removeItemFromCart(Products product) {
    _cartList.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  void increaseQuantity(Products product) {
  
         product.quantity = product.quantity  +1;
    notifyListeners();
    
 
  }

  void decreaseQuantity(Products product) {
    if (product.quantity > 1) {
      product.quantity  = product.quantity -1;
    } else {
      removeItemFromCart(product);
    }
    notifyListeners();
  }

  double getTotalPrice() {
    return _cartList.fold(0.0, (total, current) => total + (current.price! * current.quantity));
  }
}
