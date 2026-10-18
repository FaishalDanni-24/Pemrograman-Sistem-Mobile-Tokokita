// SafeArea(
//         child: Column(
//           children: [
//             // Header Halaman
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         'TokoKita',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         'Belanja jadi lebih mudah',
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ), 
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                         IconButton(
//                         icon: const Icon(Icons.shopping_cart),
//                         onPressed: () {},
//                       ),
//                       Positioned(
//                         right: 8,
//                         top: 0,
//                         child: Obx(
//                           () => cartController.totalItem > 0
//                               ? CircleAvatar(
//                                   radius: 9,
//                                   backgroundColor: Colors.red,
//                                   child: Text(
//                                     '${cartController.totalItem}',
//                                     style: const TextStyle(fontSize: 10, color: Colors.white),
//                                   ),
//                                 )
//                               : const SizedBox.shrink(),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: dummyProducts.length,
//                 itemBuilder: (context, index) {
//                   return ProductCard(product: dummyProducts[index]);
//                 },
//               ),
//             )
//           ],
//         ),
//       ),


//       FutureBuilder<List<Product>>(
//         future: futureProducts,
//         builder: (context, snapshot){
          
//           // Kondisi Loading
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           // Kondisi Error
//           else if (snapshot.hasError) {
//             return Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.error_outline, size: 60, color: Colors.red),
//                     const SizedBox(height: 12),
//                     const Text(
//                       'Gagal memuat produk, coba lagi',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '${snapshot.error}',
//                       style: const TextStyle(color: Colors.grey, fontSize: 12),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton.icon(
//                       onPressed: _retryFetch,
//                       icon: const Icon(Icons.refresh),
//                       label: const Text('Coba Lagi'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }

//           // Kondisi Data Kosong
//           else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text('Tidak ada produk tersedia.'),
//             );
//           }

//           // Kondisi Sukses Menampilkan Data
//           else {
//             final products = snapshot.data!;
//             return ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 // Menggunakan ProductCard yang sudah ada tanpa mengubah kodenya
//                 return ProductCard(product: product);
//               },
//             );
//           }
//         },
//       )