import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Something Went Wrong'),
      ),
      body: const Center(
        child: Text(
          'An unexpected error occurred. Please try again later.',
          style: TextStyle(fontSize: 18, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
