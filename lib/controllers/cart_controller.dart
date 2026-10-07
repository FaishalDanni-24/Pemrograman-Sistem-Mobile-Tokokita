import 'package:get/get.dart';

import '../models/product.dart';

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

  double get totalHarga {
    return cartItems.fold(
        0, (sum, item) => sum + (item.product.price * item.quantity.value));
  }

  void clearCart() {
    cartItems.clear();
  }
}