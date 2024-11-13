import 'package:doan_ver2/product_model.dart';

class CartItem {
  final Product product;
  int quantity;
  final DateTime dateTime;

  CartItem({required this.product, this.quantity = 1})  : dateTime = DateTime.now();
}
