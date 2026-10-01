// lib/screens/product_detail_page.dart
import 'package:flutter/material.dart';
import 'package:tokokita/widgets/discount_badge.dart';

import '../models/product.dart';
import '../widgets/price_label.dart';
import '../widgets/stock_badge.dart';
import '../widgets/category_tag.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final bool isDiscounted = product is DiscountedProduct;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        // Point 1.4: Tombol back default Flutter dipanggil secara otomatis, 
        // namun kita juga bisa membuat perilaku kustom menggunakan Navigator.pop
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk Placeholder
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.shopping_bag, size: 100, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            
            // Point 1.3: Informasi lengkap produk
            CategoryTag(category: product.category),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PriceLabel(price: product.price),
                if (isDiscounted)
                DiscountBadge(),
                StockBadge(statusStok: product.getStatusStok()),
              ],
            ),
            const Divider(height: 32),
            const Text(
              'Deskripsi Produk',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product.description ?? 'Tidak ada deskripsi tersedia.',
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () {
            int jumlahItem = 1; // Contoh kuantitas item yang ditambah
            // Point 3.2: Pop halaman dan mengembalikan nilai jumlah
            Navigator.pop(context, jumlahItem);
          },
          child: const Text('Tambah ke Keranjang', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}