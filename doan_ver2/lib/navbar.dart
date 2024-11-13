import 'package:flutter/material.dart';
import 'cart_item.dart';
import 'cart_page.dart';
import 'food_page.dart'; // Đảm bảo rằng bạn đã import trang FoodPage

class Navbar extends StatefulWidget {
  final double rightPosition;
  final List<CartItem> cartItems;
  final String token;
  final String accountID;

  const Navbar({super.key, required this.rightPosition, required this.cartItems, required this.token, required this.accountID});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  void _incrementQuantity(CartItem cartItem) {
    setState(() {
      cartItem.quantity++;
    });
  }

  void _decrementQuantity(CartItem cartItem) {
    setState(() {
      if (cartItem.quantity > 1) {
        cartItem.quantity--;
      }
    });
  }

  void _removeItem(CartItem cartItem) {
    setState(() {
      widget.cartItems.remove(cartItem);
    });
  }

  void _navigateToFoodPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FoodPage(token: widget.token, accountID: widget.accountID,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = widget.cartItems.fold(0, (total, item) => total + item.product.price * item.quantity);
    double taxAndFees = subtotal * 0.10; // 10% of subtotal
    double delivery = 15; // Fixed delivery fee in VND
    double total = subtotal + taxAndFees + delivery;

    return Container(
      width: 330,
      height: MediaQuery.of(context).size.height, // Đảm bảo chiều cao đủ lớn
      decoration: const BoxDecoration(
        color: Color(0xFFFE5621),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 44.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/iconcart_navbar.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Giỏ hàng',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  color: const Color(0xFFF5CB58),
                ),
                const SizedBox(height: 20),
                if (widget.cartItems.isEmpty)
                  const Text(
                    'Giỏ hàng của bạn đang trống!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: widget.cartItems.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: _navigateToFoodPage, // Thay đổi trang khi nhấp vào ảnh
                            child: Image.asset(
                              'assets/images/addtocart_navbar.png',
                              height: 184,
                              width: 184,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: 184,
                            ),
                            child: const Text(
                              'Gọi món ngay nào!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    )
                        : Column(
                      children: [
                        for (var item in widget.cartItems) _buildCartItem(item),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                          color: const Color(0xFFFE5621),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSummaryRow('Tạm tính', subtotal),
                              _buildSummaryRow('Phí dịch vụ', taxAndFees),
                              _buildSummaryRow('Phí vận ', delivery),
                              Divider(color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.cartItems.isNotEmpty) // Only show total and checkout button if cart is not empty
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFE5621),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40), // Bo góc dưới bên trái
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSummaryRow('Tổng tiền', total, isTotal: true),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CartDetail(cartItems: List.from(widget.cartItems), token: widget.token, rightPosition: widget.rightPosition, accountID: widget.accountID,)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              foregroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text('Thanh toán'),
                          ),
                        ),
                        SizedBox(height: 16), // Add some bottom padding
                      ],
                    ),
                  ),
              ],
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
              color: Colors.white,
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            '${amount.toStringAsFixed(3)}đ', // Changed to show 3 decimal places
            style: TextStyle(
              color: Colors.white,
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0), // Khoảng cách trái và phải 20 đơn vị
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(item.product.imageURL, height: 80, width: 80, fit: BoxFit.cover),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item.product.name,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            overflow: TextOverflow.visible, // Cho phép xuống dòng
                            softWrap: true, // Bật tính năng xuống dòng
                          ),
                        ),
                        SizedBox(width: 0), // Khoảng cách giữa tên món ăn và ngày giờ
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${item.dateTime.day}/${item.dateTime.month}/${item.dateTime.year}',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              '${item.dateTime.hour}:${item.dateTime.minute}',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(width: 10), // Khoảng cách giữa tên món ăn và ngày giờ
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${item.product.price.toStringAsFixed(3)}₫', // Changed to show 3 decimal places
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle, color: Colors.white),
                              onPressed: () => _decrementQuantity(item),
                            ),
                            Text('${item.quantity}', style: TextStyle(color: Colors.white)),
                            IconButton(
                              icon: Icon(Icons.add_circle, color: Colors.white),
                              onPressed: () => _incrementQuantity(item),
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
          Divider(color: Colors.white),
        ],
      ),
    );
  }
}
