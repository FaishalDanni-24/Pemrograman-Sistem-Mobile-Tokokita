// lib/screens/product_detail_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/product.dart';
import '../controllers/cart_controller.dart';
import '../services/product_service.dart';
import '../widgets/price_label.dart';
import '../widgets/stock_badge.dart';
import '../widgets/category_tag.dart';
import '../widgets/discount_badge.dart';

class ProductDetailPage extends StatefulWidget {
  final int? productId;
  final Product? product;

  const ProductDetailPage({super.key, this.productId, this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  late Future<Product> futureDetailProduct;
  final ProductService productService = ProductService();

  void _incrementQuantity() {
    if (quantity < widget.product!.stock) {
      setState(() {
        quantity++;
      });
    }
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      // Jika data sudah dikirim melalui Navigator arguments
      futureDetailProduct = Future.value(widget.product!);
    } else if (widget.productId != null) {
      // Jika hanya ID yang dikirim, ambil dari API
      futureDetailProduct = productService.fetchProductDetail(
        widget.productId!,
      );
    } else {
      throw Exception('Data produk atau ID produk wajib disediakan.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDiscounted = widget.product is DiscountedProduct;
    final CartController cartController = Get.find<CartController>();

    return FutureBuilder<Product>(
      future: futureDetailProduct,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Memuat Detail...')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text('Terjadi error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text('Kosong')),
            body: const Center(child: Text('Produk tidak ditemukan.')),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.product!.name),
            // Kita juga bisa membuat perilaku kustom menggunakan Navigator.pop
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
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
                  child: Image.network(
                    widget.product!.imageUrl,
                    width: 100,
                    height: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Label Kategori & Stok
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoryTag(category: widget.product!.category),
                          if (isDiscounted) DiscountBadge(),
                          StockBadge(
                            statusStok: widget.product!.getStatusStok(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Nama & Harga
                      Text(
                        widget.product!.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      PriceLabel(price: widget.product!.price),
                      const Divider(height: 32),

                      // Deskripsi
                      const Text(
                        'Deskripsi Produk',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.product!.description ??
                            'Tidak ada deskripsi tersedia.',
                        style: TextStyle(color: Colors.grey[700], height: 1.5),
                      ),
                      const SizedBox(height: 24),

                      // Kontrol Jumlah (Counter)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Jumlah Item:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: quantity > 1
                                      ? _decrementQuantity
                                      : null,
                                ),
                                Text(
                                  '$quantity',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: quantity < widget.product!.stock
                                      ? _incrementQuantity
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
              onPressed: widget.product!.stock > 0
                  ? () {
                      for (int i = 0; i < quantity; i++) {
                        cartController.addToCart(widget.product!);
                      }
                      Get.snackbar(
                        'Sukses',
                        '${widget.product!.name} berhasil ditambahkan ke keranjang',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  : null,
              child: Text(
                widget.product!.stock > 0
                    ? 'Tambah ke Keranjang ($quantity)'
                    : 'Stok Habis',
              ),
            ),
          ),
        );
      },
    );
  }
}
