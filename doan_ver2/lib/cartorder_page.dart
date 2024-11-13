import 'package:flutter/material.dart';

import 'food_page.dart';
import 'home_page.dart';
import 'favorite_page.dart';
import 'list_orderActive.dart';

class Notiorder extends StatelessWidget {
  const Notiorder({super.key, required this.token, required this.accountID});
  final String token;
  final String accountID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hoàn tất đơn hàng',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5CB58),
        leading: IconButton(
          icon: Image.asset('assets/images/iconbackrow.png'),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(token: token, accountID: accountID,)), // Navigate to HomePage
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFF5CB58),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.9, // Adjust width to be a percentage of screen width
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/cancelsequence.png'),
                            const SizedBox(height: 20),
                            const Text(
                              '¡Hoàn tất đơn hàng!',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Đơn hàng của bạn đã được đặt thành công',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ListOrder(token: token, accountID: accountID,)),
                                );
                              },
                              child: const Text(
                                'Xem chi tiết >>>',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  fontSize: 16.0,
                                  decorationColor: Colors.blue,
                                  decorationStyle: TextDecorationStyle.solid,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 80), // Adjust vertical position

                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
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
                          MaterialPageRoute(builder: (context) => HomePage(token: token, accountID: accountID,)),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.restaurant, color: Colors.white),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => FoodPage(token: token, accountID: accountID,)),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite, color: Colors.white),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => FavoritePage(token: token, accountID: accountID)),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_bag, color: Colors.white),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => ListOrder(token: token, accountID: accountID,)),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
