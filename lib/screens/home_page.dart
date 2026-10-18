import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';
import '../services/product_services.dart';
import '../widgets/product_card.dart';
import '../controllers/cart_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bool showCard = true;
  late Future<List<Product>> futureProducts;
  final ProductService productService = ProductService();
  final CartController cartController = Get.find<CartController>();

  // Saat buat Widget Home Page
  @override
  void initState(){
    super.initState();
    futureProducts = productService.fetchProducts();
  }

  // Fungsi untuk memuat ulang data saat tombol 'Coba Lagi' ditekan
  void _retryFetch() {
    setState(() {
      futureProducts = productService.fetchProducts();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog TokoKita'),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot){
          
          // Kondisi Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Kondisi Error
          else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 60, color: Colors.red),
                    const SizedBox(height: 12),
                    const Text(
                      'Gagal memuat produk, coba lagi',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _retryFetch,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Kondisi Data Kosong
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Tidak ada produk tersedia.'),
            );
          }

          // Kondisi Sukses Menampilkan Data
          else {
            final products = snapshot.data!;
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  futureProducts = productService.fetchProducts();
                });
                // Menunggu proses fetch selesai agar animasi loading berputar dengan benar
                await futureProducts;
              },
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  // Menggunakan ProductCard yang sudah ada tanpa mengubah kodenya
                  return ProductCard(product: product);
                },
              ),
            );
          }
        },
      )
    );
  }
}