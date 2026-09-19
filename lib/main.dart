import 'package:flutter/material.dart';

import 'models/product.dart';
import 'widgets/product_card.dart';

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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool showCard = true;

  final products = dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TokoKita'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showCard = !showCard;
              });
            },
            child: Text(
              showCard ? 'Sembunyikan Kartu (Uji dispose)' : 'Tampilkan Kartu',
            ),
          ),
          const SizedBox(height: 20),
          if (showCard) ProductCard(product: products[0]),
        ],
      ),
    );
  }
}
