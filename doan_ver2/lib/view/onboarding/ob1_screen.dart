import 'package:flutter/material.dart';
import '../first_screen.dart';
import 'ob2_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Hình nền
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ob1.png'),
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
                  'assets/images/iconob1.png',
                  color: Colors.red,
                ),

                // Tiêu đề
                const SizedBox(height: 20),
                const Text(
                  'Đặt Đồ Ăn',
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
                  'Trải nghiệm ẩm thực đặc biệt chỉ với vài cú nhấp chuột. Cho dù bạn ở nhà hay ở văn phòng, chỉ cần mở ứng dụng, chọn món ăn yêu thích từ thực đơn phong phú của chúng tôi và đặt hàng.',
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
                    // Chuyển sang màn hình tiếp theo
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const Ob2()), // Thay đổi tên lớp nếu cần
                    );
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
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 17,
                          decoration: TextDecoration.none,
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
