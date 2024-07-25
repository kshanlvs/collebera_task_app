import 'package:collebera_task_app/product/models/products_model.dart';
import 'package:collebera_task_app/product/providers/product_provider.dart';
import 'package:collebera_task_app/product/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'product/screens/product_detail_screen.dart';
import 'product/screens/products_screen.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      routes: [
        GoRoute(
          path: 'productDetails',
          builder: (BuildContext context, GoRouterState state) {
            final Products product =
                (state.extra as Map)['product'] as Products;

            return ProductDetailsScreen(
              product: product,
            );
          },
        ),
        GoRoute(
          path: 'cartScreen',
          builder: (BuildContext context, GoRouterState state) {
            return const CartScreen();
          },
        ),
      ],
      builder: (BuildContext context, GoRouterState state) {
        return ChangeNotifierProvider(
            create: (context) {
              return ProductProvider();
            },
            child: const ProductScreen());
      },
    ),
  ],
);
