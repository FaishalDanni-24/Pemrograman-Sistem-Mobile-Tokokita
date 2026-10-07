import 'package:get/get.dart';
import '../models/product.dart';

class CartController extends GetxController {
  // Variabel reaktif untuk menyimpan daftar item keranjang
  var cartItems = <Product>[].obs;

  // Menambahkan produk ke keranjang
  void addToCart(Product product) {
    cartItems.add(product);
  }

  // Menghapus produk dari keranjang
  void removeFromCart(Product product) {
    cartItems.remove(product);
  }

  // Getter reaktif menghitung total item
  int get totalItem => cartItems.length;

  // Getter reaktif menghitung total harga
  double get totalHarga {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }
}