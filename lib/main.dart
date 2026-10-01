import 'package:flutter/material.dart';
import 'package:tokokita/screens/main_page.dart';

import 'screens/home_page.dart';
import 'screens/product_detail_page.dart';
import 'models/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TokoKita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/detail': (context) {
          final product = ModalRoute.of(context)!.settings.arguments as Product;
          return ProductDetailPage(product: product);
        },
      },
    );
  }
}
