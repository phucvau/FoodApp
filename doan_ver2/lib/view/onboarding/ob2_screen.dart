import 'package:flutter/material.dart';
import '../first_screen.dart';
import 'ob3_screen.dart';

class Ob2 extends StatelessWidget {
  const Ob2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const OnBoarding(),
      routes: {
        '/home': (context) => const Ob3(),
      },
    );
  }
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => AOnBoarding();
}

class AOnBoarding extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hình nền
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ob2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Nội dung chính
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: ShapeDecoration(
              color: const Color(0xFFF8F8F8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Image.asset(
                  'assets/images/iconob2.png',
                  color: Colors.red,
                ),

                // Tiêu đề
                const SizedBox(height: 20),
                const Text(
                  'Thanh Toán Dễ Dàng',
                  style: TextStyle(
                    color: Color(0xFFFE5621),
                    fontSize: 24,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.none,
                  ),
                ),

                // Mô tả
                const SizedBox(height: 10),
                const Text(
                  'Ứng dụng của chúng tôi cũng cho phép bạn lưu các phương thức thanh toán ưa thích để thanh toán nhanh hơn trong tương lai. Hãy tạm biệt những rắc rối về tiền mặt và tận hưởng sự tiện lợi của các khoản thanh toán dễ dàng, an toàn và hiệu quả với Fudiee.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF391713),
                    fontSize: 14,
                    fontFamily: 'LeagueSpartan',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),

                // Dots cho indicator
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF3E9B5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 20,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFE5621),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      width: 20,
                      height: 4,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF3E9B5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),

                // Nút "Next"
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Container(
                    width: 133,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFE5621),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Tiếp theo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'LeagueSpartan',
                          color: Colors.white,
                          fontSize: 17,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Nút "Skip"
        Positioned(
          right: 20,
          top: 40,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FirstScreen()),
              );
            },
            child: Row(
              children: [
                const Text(
                  'Bỏ qua',
                  style: TextStyle(
                    color: Color(0xFFFE5621),
                    fontSize: 15,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/images/iconnextarrow.png', // Đảm bảo rằng hình ảnh đã được thêm vào thư mục assets
                  width: 15,
                  height: 15,
                  color: const Color(0xFFFE5621),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
