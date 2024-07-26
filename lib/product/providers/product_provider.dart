import 'package:collebera_task_app/product/models/products_model.dart';
import 'package:flutter/foundation.dart';

import '../../http_services/http_factory.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider() {
    fetchProducts();
  }

  final _httpClient = HttpClientFactory.createHttpClient();
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<Products> _products = [];
  List<Products> get products => _products;

  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      _products.clear();
      notifyListeners();
    }
    const String url = '/products';
    try {
      final response = await _httpClient.get(url);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        _products = data.map((e) => Products.fromJson(e)).toList();
      }
    } catch (e) {
      throw Exception('Error loading products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
