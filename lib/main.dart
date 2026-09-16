import 'package:flutter/material.dart';
import 'models/product.dart';
import 'widgets/product_cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final products = dummyProducts;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokoKita',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TokoKita'),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: Column(
            spacing: 1.0,
            children: [
              ProductCart(product: products[0]), 
              ProductCart(product: products[1]),
              ProductCart(product: products[2]),
              ProductCart(product: products[3]),
              ProductCart(product: products[4]),
            ],
          )
        ),
      ),
    );
  }
}