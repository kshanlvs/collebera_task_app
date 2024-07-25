import 'package:collebera_task_app/product/providers/cart_provider.dart';
import 'package:collebera_task_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async{

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create:(context) {
     return CartProvider();
    },)],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Logistifie',
      theme: _themeData(),
    );
  }

  ThemeData _themeData() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      colorScheme: const ColorScheme.light(
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.blueAccent,
        onSecondary: Colors.white,
        background: Colors.white,
        surface: Colors.white,
        onBackground: Colors.black,
        onSurface: Colors.black,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
        bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
        titleLarge: TextStyle(color: Colors.black, fontSize: 20),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blueAccent,
        textTheme: ButtonTextTheme.primary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.blueAccent,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    );
  }
}