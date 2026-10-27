import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/product_detail_page.dart';
import '../models/product.dart';

import 'discount_badge.dart';
import 'price_label.dart';
import 'stock_badge.dart';
import 'category_tag.dart';

// ProductCard (Stateless)
// class ProductCard extends StatelessWidget {
//   final Product product;

//   const ProductCard({
//     super.key,
//     required this.product
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.all(12.0),
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             // Placeholder Gambar Produk
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(
//                 Icons.shopping_bag,
//                 size: 40,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(width: 16),
//             // Detail Produk (Nama & Harga)
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     product.name,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Rp ${product.price.toStringAsFixed(0)}',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.green,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ProductCard extends StatefulWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback? onFavoriteChanged;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    this.onFavoriteChanged,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // State wishlist
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  // Memeriksa apakah ID produk ada di SharedPreferences saat card dimuat
  Future<void> _checkFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIds = prefs.getStringList('favorite_ids') ?? [];
    setState(() {
      _isFavorite = favoriteIds.contains(widget.product.id.toString());
    });
  }

  // Toggle status favorit dan simpan ke SharedPreferences
  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favorite_ids') ?? [];
    String idStr = widget.product.id.toString();

    setState(() {
      if (_isFavorite) {
        favoriteIds.remove(idStr);
        _isFavorite = false;
      } else {
        favoriteIds.add(idStr);
        _isFavorite = true;
      }
    });

    await prefs.setStringList('favorite_ids', favoriteIds);
    if (widget.onFavoriteChanged != null) {
      widget.onFavoriteChanged!();
    }
  }

  @override
  void dispose() {
    // Lifecycle: dispose dipanggil saat Widget dihapus dari Widget Tree
    print(
      '<-- [dispose] ProductCard dihapus dari tree untuk produk: ${widget.product.name}',
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lifecycle: build dipanggil saat awal rendernya widget & setiap kali setState() dipanggil
    print(
      '==> [build] ProductCard dipanggil (isFavorite: ${widget.isFavorite}',
    );
    // Memeriksa apakah produk merupakan produk diskon
    final bool isDiscounted = widget.product is DiscountedProduct;

    return InkWell(
      onTap: () async {
        final result = await Get.to(
          () => ProductDetailPage(product: widget.product),
        );

        if (result != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '$result item "${widget.product.name}" berhasil ditambahkan ke keranjang!',
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    widget.product.imageUrl,
                    width: 20,
                    height: 20,
                  ),
                ),

                // Badge diskon
                if (isDiscounted)
                  Positioned(top: 4, right: 4, child: DiscountBadge()),
                Positioned(
                  bottom: 4,
                  left: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: widget.product.stock > 0
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.product.stock > 0
                          ? 'Stok: ${widget.product.stock}'
                          : 'Habis',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Detail Produk (Nama, Badge Stok, & Harga)
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Penggunaan Widget Custom Baru CategoryTag
                  CategoryTag(category: widget.product.category),
                  const SizedBox(height: 4),
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),
                  // Penggunaan StockBadge
                  StockBadge(statusStok: widget.product.getStatusStok()),

                  const SizedBox(height: 8),
                  // Penggunaan PriceLabel
                  PriceLabel(price: widget.product.price),
                ],
              ),
            ),

            // Tombol Favorit (Love/Star)
            IconButton(
              icon: Icon(
                widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: widget.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: _toggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}
