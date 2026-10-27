import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<Product> _wishlistProducts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    setState(() => _isLoading = true);
    final prefs = await SharedPreferences.getInstance();
    List<String> favIds = prefs.getStringList('favorite_ids') ?? [];

    if (favIds.isEmpty) {
      setState(() {
        _wishlistProducts = [];
        _isLoading = false;
      });
      return;
    }

    try {
      List<Product> allProducts = await ProductService().fetchProducts();
      List<Product> filtered = allProducts
          .where((p) => favIds.contains(p.id.toString()))
          .toList();

      setState(() {
        _wishlistProducts = filtered;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  // Menghapus produk dari SharedPreferences & UI secara langsung
  Future<void> _removeFromWishlist(String idStr) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favIds = prefs.getStringList('favorite_ids') ?? [];
    favIds.remove(idStr);
    await prefs.setStringList('favorite_ids', favIds);
    _loadWishlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist Saya')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _wishlistProducts.isEmpty
              ? const Center(child: Text('Wishlist masih kosong.'))
              : ListView.builder(
                  itemCount: _wishlistProducts.length,
                  itemBuilder: (context, index) {
                    final product = _wishlistProducts[index];
                    return ListTile(
                      leading: Image.network(
                        product.imageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name),
                      subtitle: Text('Rp ${product.price}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            _removeFromWishlist(product.id.toString()),
                      ),
                    );
                  },
                ),
    );
  }
}