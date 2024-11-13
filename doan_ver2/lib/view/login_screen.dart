import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../favorite_page.dart';
import '../home_page.dart';
import 'signup_screen.dart'; // Đảm bảo rằng bạn đã tạo SignUpPage

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _accountIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureEmailOrPhoneNumber = true;

  Future<void> _login() async {
    try {
      final uri = Uri.parse('https://huflit.id.vn:4321/api/Auth/login');
      final request = http.MultipartRequest('POST', uri)
        ..fields['AccountID'] = _accountIdController.text.trim()
        ..fields['Password'] = _passwordController.text.trim();

      final response = await http.Response.fromStream(await request.send());

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final token = jsonResponse['data']['token'] as String;


        final String accountID = _accountIdController.text.trim();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(token: token, accountID:accountID)),
        );


      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng nhập thất bại. Sai tài khoản hoặc mật khẩu.')),
        );
      }
    } catch (e) {
      print('Error logging in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xảy ra lỗi khi đăng nhập. Vui lòng thử lại sau.')),
      );
    }
  }

  // Function to navigate to SignupPage
  void _goToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }


  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleEmailOrPhoneNumberVisibility() {
    setState(() {
      _obscureEmailOrPhoneNumber = !_obscureEmailOrPhoneNumber;
    });
  }

  @override
  void dispose() {
    _accountIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5CB58), // Màu nền của Scaffold toàn bộ ứng dụng
    ),
      home: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
              'assets/images/iconbackrow.png'), // Đặt hình ảnh cho nút back
          onPressed: () {
            Navigator.pop(context); // Quay lại trang trước đó
          },
        ),
        title: const Text(
          'Đăng nhập',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5CB58),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              height: 720,
              color: const Color(0xFFF5CB58),
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Chào mừng',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Trải nghiệm sự tiện lợi khi đặt món ăn yêu thích ngay trong tầm tay. Cho dù bạn thèm pizza, sushi hay burger thịnh soạn, ứng dụng của chúng tôi giúp bạn dễ dàng thỏa mãn cơn thèm. Đăng nhập ngay để khám phá thực đơn đa dạng của chúng tôi và đặt hàng chỉ bằng vài thao tác chạm.',
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Tên tài khoản',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _accountIdController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFF3E9B5),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Mật khẩu',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF3E9B5),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: const Color(0xFFE95322),
                                    ),
                                    onPressed: _togglePasswordVisibility,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Thêm hành động quên mật khẩu tại đây
                              print('Forgot Password pressed');
                            },
                            child: const Text(
                              'Quên Mật Khẩu?',
                              style: TextStyle(
                                color: Color(0xFFE95322),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFE95322), // màu nền
                              foregroundColor: Colors.white, // màu chữ
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                            ),
                            child: const Text('Đăng nhập'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            'Khác',
                            style: TextStyle(
                              color: Color(0xFFE95322),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Thêm hành động đăng ký bằng Google tại đây
                              },
                              icon: Image.asset('assets/icons/ggicon.png'),
                              iconSize: 40,
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () {
                                // Thêm hành động đăng ký bằng Facebook tại đây
                              },
                              icon: Image.asset('assets/icons/fbicon.png'),
                              iconSize: 40,
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                                onPressed: () {
                                  // Thêm hành động đăng ký bằng số điện thoại tại đây
                                },
                                icon: Image.asset('assets/icons/phoneicon.png'),
                                iconSize: 40),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(40.0),
      //     topRight: Radius.circular(40.0),
      //   ),
      //   child: BottomAppBar(
      //     color: const Color(0xFFFE5621),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         IconButton(
      //           icon: const Icon(Icons.home, color: Colors.white),
      //           onPressed: () {},
      //         ),
      //         IconButton(
      //           icon: const Icon(Icons.restaurant, color: Colors.white),
      //           onPressed: () {},
      //         ),
      //         IconButton(
      //           icon: const Icon(Icons.favorite, color: Colors.white),
      //           onPressed: () {},
      //         ),
      //         IconButton(
      //           icon: const Icon(Icons.shopping_bag, color: Colors.white),
      //           onPressed: () {},
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      ),
    );
  }
}
