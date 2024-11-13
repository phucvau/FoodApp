import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // Variable to track selected payment method
  String _selectedMethod = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5CB58),
      body: Stack(
        children: [
          Positioned(
            top: 73,
            left: 0,
            right: 0,
            child: Row(
              children: [
                SizedBox(width: 35),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Quay lại trang trước đó
                  },
                  child: Image.asset(
                    'assets/images/iconbackrow.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                Spacer(),
                Text(
                  'Phương thức thanh toán',
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
            top: 129,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title with increased size and margin
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Các phương thức thanh toán',
                            style: TextStyle(
                              fontSize: 21, // Increased size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Credit Card Payment Method with shadow box
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 'creditCard';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethod == 'creditCard' ? Color(0xFFFFDECF) : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/iconcart.png',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Credit Card',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('Edit button clicked');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFFDECF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: SizedBox(
                                      width: 150,
                                      child: Center(
                                        child: Text(
                                          '*** *** *** 43 /00 /000',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Cash on Delivery Payment Method with shadow box
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMethod = 'cashOnDelivery';
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _selectedMethod == 'cashOnDelivery' ? Color(0xFFFFDECF) : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 4),
                                  blurRadius: 8,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/iconcart.png', // Replace with an appropriate icon if needed
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Thanh toán khi nhận hàng',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 60, // Cách từ đáy màn hình đến nút "Pay Now"
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Quay lại trang CartDetail
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFE5621), // Màu nền của nút
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'Xác nhận',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
