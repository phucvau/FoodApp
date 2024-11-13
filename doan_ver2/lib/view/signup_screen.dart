import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'dart:convert';
import 'login_screen.dart'; // Import trang LoginScreen

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final TextEditingController _accountIDController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://huflit.id.vn:4321/api/Student/signUp'),
      );

      request.fields['FullName'] = _fullNameController.text;
      request.fields['PhoneNumber'] = _phoneNumberController.text;
      request.fields['Gender'] = _genderController.text;
      request.fields['NumberID'] = _numberIDController.text;
      request.fields['AccountID'] = _accountIDController.text;
      request.fields['SchoolKey'] = _schoolKeyController.text;
      request.fields['SchoolYear'] = _schoolYearController.text;
      request.fields['Birthday'] = _birthdayController.text;
      request.fields['Password'] = _passwordController.text;
      request.fields['ConfirmPassword'] = _confirmPasswordController.text;

      var response = await request.send();

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng ký thành công')),
        );
        Navigator.pop(
            // ignore: use_build_context_synchronously
            context); // Quay lại trang đăng nhập sau khi đăng ký thành công
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đăng ký thất bại')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(115.0), // Chiều cao mới cho AppBar
        child: AppBar(
          leading: IconButton(
            icon: Image.asset(
                'assets/images/iconbackrow.png'), // Biểu tượng "Back"
            onPressed: () {
              Navigator.pop(context); // Quay lại màn hình trước đó
            },
          ),
          title: const Text(
            'Đăng ký',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFF5CB58),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              color: const Color(0xFFF5CB58),
              padding: const EdgeInsets.all(0.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(19.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tạo tài khoản',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildTextField('Họ tên', _fullNameController),
                          const SizedBox(height: 20),
                          _buildTextField(
                              'Số điện thoại', _phoneNumberController),
                          const SizedBox(height: 20),
                          _buildTextField('Giới tính', _genderController),
                          const SizedBox(height: 20),
                          _buildTextField('ID', _numberIDController),
                          const SizedBox(height: 20),
                          _buildTextField('ID tài khoản', _accountIDController),
                          const SizedBox(height: 20),
                          _buildTextField('Mã trường', _schoolKeyController),
                          const SizedBox(height: 20),
                          _buildTextField('Năm học', _schoolYearController),
                          const SizedBox(height: 20),
                          _buildTextField('Ngày sinh', _birthdayController),
                          const SizedBox(height: 20),
                          _buildPasswordField('Mật khẩu', _passwordController,
                              _togglePasswordVisibility, _obscurePassword),
                          const SizedBox(height: 20),
                          _buildPasswordField(
                              'Xác nhận mật khẩu',
                              _confirmPasswordController,
                              _toggleConfirmPasswordVisibility,
                              _obscureConfirmPassword),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: _signUp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF5CB58),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: const Text('Đăng ký'),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              'hoặc đăng ký bằng',
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
                                  // Add Google sign up action
                                },
                                icon: Image.asset('assets/icons/ggicon.png'),
                                iconSize: 40,
                              ),
                              const SizedBox(width: 20),
                              IconButton(
                                onPressed: () {
                                  // Add Facebook sign up action
                                },
                                icon: Image.asset('assets/icons/fbicon.png'),
                                iconSize: 40,
                              ),
                              const SizedBox(width: 20),
                              IconButton(
                                onPressed: () {
                                  // Add PhoneNumber sign up action
                                },
                                icon: Image.asset('assets/icons/phoneicon.png'),
                                iconSize: 40,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Đã có tài khoản? ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                    color: Color(0xFFFE5621),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
    );
  }

  Widget _buildTextField(String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $labelText';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField(String labelText, TextEditingController controller,
      VoidCallback toggleVisibility, bool obscureText,
      {TextEditingController? confirmPassword}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            suffixIcon: IconButton(
              icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
              onPressed: toggleVisibility,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your $labelText';
            }
            if (confirmPassword != null && value != confirmPassword.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }
}
