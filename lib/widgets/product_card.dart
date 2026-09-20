import 'package:flutter/material.dart';
import '../models/product.dart';
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

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // State lokal untuk menyimpan status favorit
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Lifecycle: initState dipanggil sekali saat Widget State dibuat
    print('--> [initState] ProductCard dibuat untuk produk: ${widget.product.name}');
  }

  @override
  void dispose() {
    // Lifecycle: dispose dipanggil saat Widget dihapus dari Widget Tree
    print('<-- [dispose] ProductCard dihapus dari tree untuk produk: ${widget.product.name}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lifecycle: build dipanggil saat awal rendernya widget & setiap kali setState() dipanggil
    print('==> [build] ProductCard dipanggil (isFavorite: $isFavorite)');

    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Placeholder Gambar Produk
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.shopping_bag,
                size: 40,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            
            // Detail Produk (Nama, Badge Stok, & Harga)
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
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}