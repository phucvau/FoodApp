import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doan_ver2/product_model.dart';

class ProductService {
  final String baseUrl = 'https://huflit.id.vn:4321/api';

  Future<List<Product>> fetchProducts(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Product/getList?accountID=phucvau'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((model) => Product.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> fetchProductsByCategory(String token, int categoryId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Product/getListByCatId?categoryID=$categoryId&accountID=phucvau'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Iterable list = jsonDecode(response.body);
      return list.map((model) => Product.fromJson(model)).toList();
    } else {
      throw Exception('Failed to load products by category');
    }
  }
}
