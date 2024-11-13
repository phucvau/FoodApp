import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'detailBill_page.dart';
import 'food_page.dart';
import 'home_page.dart';

import 'list_orderCancelled.dart';
import 'list_orderComplete.dart'; // Ensure you have the correct import path

class ListOrder extends StatefulWidget {
  const ListOrder({super.key, required this.token, required this.accountID});
  final String token;
  final String accountID;

  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  String _selectedStatus = 'Active';
  List<dynamic> _orders = []; // List to store orders
  bool _isLoading = true; // Flag to indicate loading state
  String _errorMessage = ''; // Error message if any

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _errorMessage = ''; // Reset error message
    });

    try {
      final response = await http.get(
        Uri.parse('https://huflit.id.vn:4321/api/Bill/getHistory'),
        headers: {
          'accept': '*/*',
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        // Debugging: print the response body
        print('Response body: ${response.body}');

        setState(() {
          _orders = json.decode(response.body);

          // Sắp xếp đơn hàng theo ngày tạo giảm dần
          DateFormat format = DateFormat('dd/MM/yyyy'); // Define the date format

          _orders.sort((a, b) {
            DateTime dateA = format.parse(a['dateCreated']);
            DateTime dateB = format.parse(b['dateCreated']);
            return dateB.compareTo(dateA);
          });

          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load orders';
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

  void _onStatusSelected(String status) {
    setState(() {
      _selectedStatus = status;
    });
  }

  Future<void> _deleteOrder(String orderId) async {
    final uri = Uri.parse('https://huflit.id.vn:4321/api/Bill/remove?billID=$orderId');
    final response = await http.delete(
      uri,
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      // Xóa thành công, cập nhật danh sách đơn hàng
      _fetchOrders(); // Tải lại danh sách đơn hàng
    } else {
      // Xử lý lỗi khi xóa không thành công
      final errorMessage = json.decode(response.body)['error'] ?? 'Failed to delete order';
      setState(() {
        _errorMessage = errorMessage;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5CB58),
      body: Stack(
        children: [
          Positioned.fill(
            top: 120,
            bottom: 40,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40.0), // Box with rounded corners
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _statusButton('Hoạt động'),
                        _statusButton('Hoàn thành'),
                        _statusButton('Đã huỷ'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : _errorMessage.isNotEmpty
                        ? Center(child: Text(_errorMessage))
                        : _buildListView(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Container(
              color: Color(0xFFF5CB58),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage(token: widget.token, accountID: widget.accountID,)),
                            (Route<dynamic> route) => false,
                      );
                    },
                    child: Image.asset(
                      'assets/images/iconbackrow.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 0),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Đơn hàng của tôi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 20,
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomAppBar(
          color: Color(0xFFFE5621),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(token: widget.token, accountID: widget.accountID,)),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.restaurant, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => FoodPage(token: widget.token, accountID: widget.accountID,)),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.shopping_bag, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ListOrder(token: widget.token, accountID: widget.accountID,)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusButton(String status) {
    bool isSelected = _selectedStatus == status;
    return ElevatedButton(
      onPressed: () => _onStatusSelected(status),
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Color(0xFFFE5621),
        backgroundColor: isSelected ? Color(0xFFFE5621) : Color(0xFFFFDECF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(status),
    );
  }

  Widget _buildListView() {
    // Lọc đơn hàng theo trạng thái được chọn
    List<dynamic> orders = _orders.where((order) {
      // Thay đổi điều kiện lọc theo yêu cầu
      return _selectedStatus == 'Active'; // Lọc theo trạng thái nếu cần
    }).toList();

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OrderDetailPage(
                orderId: order['id'],
                token: widget.token,
              ),
            ));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 35.0, vertical: 8.0),
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 4,
                ),
              ],
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['fullName'] ?? 'N/A',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(order['dateCreated'] ?? 'N/A'),
                      SizedBox(height: 8),
                      Text(
                        'Đang hoạt động',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CompletePage(orderId: order['id']),
                        ));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        _deleteOrder(order['id']);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
