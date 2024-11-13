import 'package:flutter/material.dart';
import '../first_screen.dart';

class Ob3 extends StatelessWidget {
  const Ob3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fuudie',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoarding(title: 'Fuddie'),
    );
  }
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key, required this.title});
  final String title;
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
                image: AssetImage('assets/images/ob3.png'),
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
                  'assets/images/iconob3.png',
                  color: Colors.red,
                ),

                // Tiêu đề
                const SizedBox(height: 20),
                const Text(
                  'Giao Hàng Nhanh Chóng',
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
                  'Với tính năng theo dõi thời gian thực, bạn có thể theo dõi đơn hàng của mình mọi bước. Thưởng thức những bữa ăn nóng hổi, ​​thơm ngon được giao nhanh chóng, vì chúng tôi biết rằng khi bạn đói, từng phút đều có giá trị.',
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
                  ],
                ),

                // Nút "Get Started"
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const FirstScreen()), // Chuyển đến màn hình FirstScreen
                    );
                  },
                  child: Container(
                    width: 150,
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
                        'Bắt đầu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
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
      ],
    );
  }
}
