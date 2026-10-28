import 'package:get/get.dart';

import '../models/product.dart';
import '../services/order_database.dart';

class CartItem {
  final Product product;
  RxInt quantity;

  CartItem({required this.product, required int quantity})
      : quantity = quantity.obs;
}

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  void addToCart(Product product, {int count = 1}) {
    int index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      cartItems[index].quantity.value += count;
    } else {
      cartItems.add(CartItem(product: product, quantity: count));
    }
  }

  void incrementQuantity(CartItem item) {
    item.quantity.value++;
    cartItems.refresh(); // Memicu pembaruan getter reaktif
  }

  void decrementQuantity(CartItem item) {
    if (item.quantity.value > 1) {
      item.quantity.value--;
      cartItems.refresh();
    } else {
      removeFromCart(item);
    }
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
  }

  int get totalItem {
    return cartItems.fold(0, (sum, item) => sum + item.quantity.value);
  }

  // Menghitung total harga belanja
  double get totalHarga {
    return cartItems.fold(
        0, (sum, item) => sum + (item.product.price * item.quantity.value));
  }

  // Membersihkan keranjang
  void clearCart() {
    cartItems.clear();
  }

  // Alur Checkout
  Future<bool> checkoutCart() async {
    if (cartItems.isEmpty) return false;

    // Gabungkan nama item untuk ringkasan daftarItem
    String daftarItemString = cartItems
        .map((item) => "${item.product.name} (${item.quantity}x)")
        .join(', ');

    // 1. Simpan pesanan baru ke SQLite
    await OrderDatabase.instance.insertOrder({
      'tanggal': DateTime.now().toIso8601String(),
      'daftarItem': daftarItemString,
      'totalHarga': totalHarga,
      'status': 'Diproses',
    });

    // 2. Kosongkan keranjang
    cartItems.clear();
    
    return true;
  }
}