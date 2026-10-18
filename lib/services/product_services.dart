import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Ubah response.body (string JSON) menjadi List dynamic menggunakan jsonDecode
      List<dynamic> body = jsonDecode(response.body);

      // Petakan setiap elemen map menjadi objek Product
      List<Product> products = body
          .map((dynamic item) => Product.fromJson(item))
          .toList();

      return products;
    } else {
      throw Exception(
        'Gagal memuat produk dari server (Code: ${response.statusCode})',
      );
    }
  }

  Future<Product> fetchProductDetail(int id) async {
  final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = jsonDecode(response.body);
      return Product.fromJson(jsonBody);
    } else {
      throw Exception('Gagal memuat detail produk (Code: ${response.statusCode})');
    }
  }
}
