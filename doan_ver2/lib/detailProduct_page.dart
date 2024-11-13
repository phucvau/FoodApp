import 'package:flutter/material.dart';
import 'package:doan_ver2/product_model.dart';
import 'package:http/http.dart' as http;

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final String token;
  final void Function(Product, int) addToCart;

  const ProductDetailPage({
    Key? key,
    required this.product,
    required this.addToCart, required this.token,
  }) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  bool _isFavorite = false;

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _addToCart() {
    widget.addToCart(widget.product, _quantity);
    Navigator.pop(context);
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite; // Toggle favorite status
    });

    try {
      final uri = Uri.parse('https://huflit.id.vn:4321/api/addProduct');
      final request = http.MultipartRequest('POST', uri)
        ..headers['accept'] = '*/*'
        ..headers['Authorization'] = 'Bearer ${widget.token}'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..fields['Name'] = widget.product.name
        ..fields['Description'] = widget.product.description
        ..fields['ImageURL'] = widget.product.imageURL
        ..fields['Price'] = widget.product.price.toString()
        ..fields['CategoryID'] = '4229';

      final response = await request.send();

      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print('Product added to favorite');
      } else {
        print('Failed to add product to favorite');
        print('Status Code: ${response.statusCode}');
        print('Response Body: $responseBody');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.product.name),
        backgroundColor: Color(0xFFF5CB58),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Image.network(
                          widget.product.imageURL,
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      widget.product.name,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: [
                        Text(
                          '${widget.product.price.toStringAsFixed(3)}đ',
                          style: TextStyle(fontSize: 20, color: Colors.orange),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: _decreaseQuantity,
                            ),
                            Text(
                              _quantity.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: _increaseQuantity,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(widget.product.description),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton.icon(
              onPressed: _addToCart,
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              label: Text('Thêm vào giỏ'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
