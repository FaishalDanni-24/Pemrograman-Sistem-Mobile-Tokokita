import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/checkout_page.dart';
import '../controllers/cart_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void _showClearCartDialog(BuildContext context, CartController cartController) {
      Get.defaultDialog(
        title: 'Kosongkan Keranjang',
        middleText: 'Apakah Anda yakin ingin menghapus semua item dari keranjang?',
        textConfirm: 'Ya, Kosongkan',
        textCancel: 'Batal',
        confirmTextColor: Colors.white,
        onConfirm: () {
          cartController.clearCart();
          Get.back(); // Menutup dialog
        },
      );
    }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        actions: [
          // Tombol Kosongkan Keranjang di AppBar (hanya aktif jika keranjang tidak kosong)
          Obx(
            () => cartController.cartItems.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete_sweep, color: Colors.red),
                    tooltip: 'Kosongkan Keranjang',
                    onPressed: () => _showClearCartDialog(context, cartController),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(child: Text('Keranjang Anda masih kosong'));
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartController.cartItems[index];
                  return ListTile(
                    leading: Image.network(
                      item.product.imageUrl,
                      width: 50,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image),
                    ),
                    title: Text(item.product.name),
                    subtitle: Text('Rp ${item.product.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => cartController.removeFromCart(item),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Total Harga:'),
                      Obx(
                        () => Text(
                          'Rp ${cartController.totalHarga}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: cartController.cartItems.isEmpty
                        ? null
                        : () {
                            Get.off(() => const CheckoutPage());
                          },
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
