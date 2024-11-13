import 'package:doan_ver2/cartorder_page.dart';
import 'package:doan_ver2/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cart_item.dart';
import 'home_page.dart';

class CartDetail extends StatefulWidget {
  final double rightPosition;
  final List<CartItem> cartItems;
  final String token;
  final String accountID;


  const CartDetail({
    super.key,
    required this.rightPosition,
    required this.cartItems,
    required this.token, required this.accountID,
  });

  @override
  _CartDetailState createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> {
  @override
  Widget build(BuildContext context) {
    double subtotal = widget.cartItems
        .fold(0.0, (total, item) => total + item.product.price * item.quantity);
    double taxAndFees = subtotal * 0.10; // 10% of subtotal
    double delivery = 15; // Fixed delivery fee in VND
    double total = subtotal + taxAndFees + delivery;

    return Scaffold(
      backgroundColor: Color(0xFFF5CB58),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Row(
              children: [
                SizedBox(width: 35),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          token: widget.token, accountID: widget.accountID,
                        ),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: Image.asset(
                    'assets/images/iconbackrow.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                Spacer(),
                Text(
                  'Xác nhận đơn hàng',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                SizedBox(width: 59),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 5),
                              child: Text(
                                'Địa chỉ giao hàng',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, top: 5),
                              child: Image.asset(
                                'assets/images/iconwrite.png',
                                width: 24,
                                height: 24,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                          onTap: () {
                            print('Container clicked');
                          },
                          child: Container(
                            width: double.infinity,
                            height: 35,
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color(0xFFF3E9B5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 15, right: 15),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '592 Hồ Học Lãm, Bình Tân',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Thông tin đơn hàng',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Column(
                          children: widget.cartItems
                              .map((item) => _buildCartItem(item))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(), // Navigate to PaymentPage
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, -4),
                            blurRadius: 8, // Độ mờ của bóng
                            // spreadRadius: 2, // Mở rộng bóng ra ngoài container
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hình thức thanh toán',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 16.0),
                    decoration: BoxDecoration(

                      color: Colors.white, // Đổi màu nền thành trắng
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          // Màu sắc của bóng đổ
                          offset: Offset(0, -4),
                          // Bóng đổ chỉ xuất hiện ở phía trên
                          blurRadius: 8, // Độ mờ của bóng đổ
                        ),
                      ],
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20), // Bo tròn chỉ phía trên
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSummaryRow('Tạm tính', subtotal),
                        _buildSummaryRow('Phí dịch vụ', taxAndFees),
                        _buildSummaryRow('Phí vận ', delivery),
                        _buildSummaryRow('Tổng tiền', total, isTotal: true),
                        Divider(color: Colors.orange),
                        SizedBox(height: 16),
                        // Thêm khoảng cách giữa tổng và nút
                        ElevatedButton(
                          onPressed: () {
                            _placeOrder();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Notiorder(token: widget.token, accountID: widget.accountID,)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFE5621),
                            // Màu nền của nút
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Center(
                            child: Text(
                              'Xác nhận',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '${amount.toStringAsFixed(3)}₫', // Changed to show 3 decimal places
            style: TextStyle(
              color: Colors.black,
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      // Khoảng cách trái và phải 20 đơn vị
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Hiển thị ảnh sản phẩm
                  Image.network(item.product.imageURL,
                      height: 80, width: 80, fit: BoxFit.cover),
                  Positioned(
                    top: -12,
                    left: -12,
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeItem(item),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.product.name, // Hiển thị tên sản phẩm
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            overflow: TextOverflow
                                .ellipsis, // Thêm tính năng xuống dòng nếu cần
                          ),
                        ),
                        SizedBox(width: 10),
                        // 20 units space between name and date/time
                        Text(
                          '${item.dateTime.day}/${item.dateTime.month}/${item.dateTime.year}', // Hiển thị ngày
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(width: 16),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.product.price.toStringAsFixed(3)}₫', // Hiển thị giá sản phẩm
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, size: 16),
                              onPressed: () => _updateQuantity(item, -1),
                            ),
                            Text(
                              '${item.quantity}', // Hiển thị số lượng sản phẩm
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            IconButton(
                              icon: Icon(Icons.add, size: 16),
                              onPressed: () => _updateQuantity(item, 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: Colors.orange),
        ],
      ),
    );
  }

  void _updateQuantity(CartItem item, int change) {
    setState(() {
      if (item.quantity + change > 0) {
        item.quantity += change;
      }
    });
  }

  void _removeItem(CartItem item) {
    setState(() {
      widget.cartItems.remove(item);
    });
  }

  Future<void> _placeOrder() async {
    // Tính toán subtotal
    double subtotal = widget.cartItems
        .fold(0, (total, item) => total + item.product.price * item.quantity);


    // Prepare the order details
    final orderItems = widget.cartItems.map((item) {
      return {
        "productID": item.product.id, // Assuming id is the identifier
        "count": item.quantity,
      };
    }).toList();

    final orderData = jsonEncode(orderItems);

    final response = await http.post(
      Uri.parse('https://huflit.id.vn:4321/api/Order/addBill'),
      headers: {
        'accept': '*/*',
        'Authorization': 'Bearer ${widget.token}',
        'Content-Type': 'application/json',
      },
      body: orderData,
    );

    if (response.statusCode == 200) {
      // Handle successful response
      print('Order placed successfully');

    } else {
      // Handle error response
      print('Failed to place order: ${response.reasonPhrase}');
    }
  }
}