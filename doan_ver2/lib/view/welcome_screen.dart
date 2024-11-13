import 'package:doan_ver2/view/signup_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CB58),
        elevation: 0, // Loại bỏ bóng của AppBar
        automaticallyImplyLeading: false, // Loại bỏ nút back
      ),
      body: Container(
        color: Color(0xFFF5CB58), // Đặt màu nền của Container
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/FuddieYL.jpg',
                  width: 500,
                  height: 300,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter, // Canh nút lên đầu trang
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFFFE5621),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Khoảng cách giữa các nút
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'SignUp',
                        style: TextStyle(
                          color: Color(0xFFFE5621),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
