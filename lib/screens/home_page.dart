import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';
import '../widgets/product_card.dart';
import '../controllers/cart_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bool showCard = true;
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header Halaman
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'TokoKita',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Belanja jadi lebih mudah',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ), 
                  Stack(
                    alignment: Alignment.center,
                    children: [
                        IconButton(
                        icon: const Icon(Icons.shopping_cart),
                        onPressed: () {},
                      ),
                      Positioned(
                        right: 8,
                        top: 0,
                        child: Obx(
                          () => cartController.totalItem > 0
                              ? CircleAvatar(
                                  radius: 9,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    '${cartController.totalItem}',
                                    style: const TextStyle(fontSize: 10, color: Colors.white),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: dummyProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: dummyProducts[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}