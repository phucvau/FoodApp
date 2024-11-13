import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderDetailPage extends StatefulWidget {
  final String orderId;
  final String token;

  const OrderDetailPage({super.key, required this.orderId, required this.token});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  List<dynamic>? _products;
  bool _isLoading = true;
  String _errorMessage = '';
  double _subTotal = 0.0; // For calculating the subtotal

  @override
  void initState() {
    super.initState();
    _fetchOrderDetails();
  }

  Future<void> _fetchOrderDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.post(
        Uri.parse('https://huflit.id.vn:4321/api/Bill/getByID?billID=${widget.orderId}'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      // Debugging: Print status code and response body
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        setState(() {
          _products = json.decode(response.body);
          _subTotal = (_products ?? []).fold(0.0, (sum, item) {
            final price = (item['price'] as num?)?.toDouble() ?? 0.0;
            return sum + price;
          });
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load order details. Status code: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double serviceFee = _subTotal * 0.10;
    final double shippingFee = 15.000;
    final double totalAmount = _subTotal + serviceFee + shippingFee;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết đơn hàng'),
        backgroundColor: Color(0xFFF5CB58),
      ),
      body: Container(
        color: Colors.white, // Background color of the page
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _errorMessage.isNotEmpty
                  ? Center(child: Text(_errorMessage))
                  : ListView.builder(
                itemCount: _products?.length ?? 0,
                itemBuilder: (context, index) {
                  final product = _products?[index];
                  final price = (product?['price'] as num?)?.toDouble().toStringAsFixed(3) ?? '0.000';
                  final count = product?['count'] ?? 0;

                  return Card(
                    color: Colors.white, // Background color of the list items
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.network(product?['imageURL'] ?? ''),
                      title: Text(product?['productName'] ?? 'N/A'),
                      subtitle: Text('Giá: $price VND\nSố lượng: $count'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 4), // Shadow position
                  ),
                ],
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tạm tính:', style: TextStyle(fontSize: 16)),
                      Text('${_subTotal.toStringAsFixed(3)} VND', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phí dịch vụ:', style: TextStyle(fontSize: 16)),
                      Text('${serviceFee.toStringAsFixed(3)} VND', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Phí vận chuyển:', style: TextStyle(fontSize: 16)),
                      Text('${shippingFee.toStringAsFixed(3)} VND', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  Divider(color: Colors.black, thickness: 1), // Divider above the text section
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tổng tiền:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('${totalAmount.toStringAsFixed(3)} VND', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
