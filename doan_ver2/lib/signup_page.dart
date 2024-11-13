import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _numberIdController = TextEditingController();
  final TextEditingController _accountIdController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();

  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://huflit.id.vn:4321/api/Student/signUp'),
      );

      request.fields['Gender'] = _genderController.text;
      request.fields['NumberID'] = _numberIdController.text;
      request.fields['AccountID'] = _accountIdController.text;
      request.fields['SchoolKey'] = _schoolKeyController.text;
      request.fields['SchoolYear'] = _schoolYearController.text;
      request.fields['ImageURL'] = '';
      request.fields['PhoneNumber'] = _phoneNumberController.text;
      request.fields['FullName'] = _fullNameController.text;
      request.fields['ConfirmPassword'] = _confirmPasswordController.text;
      request.fields['Password'] = _passwordController.text;
      request.fields['BirthDay'] = _birthDayController.text;

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng ký thành công')),
        );
        Navigator.pop(context); // Quay lại trang đăng nhập sau khi đăng ký thành công
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng ký thất bại')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numberIdController,
                decoration: InputDecoration(labelText: 'Number ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your number ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _accountIdController,
                decoration: InputDecoration(labelText: 'Account ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your account ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _schoolKeyController,
                decoration: InputDecoration(labelText: 'School Key'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your school key';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _schoolYearController,
                decoration: InputDecoration(labelText: 'School Year'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your school year';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _birthDayController,
                decoration: InputDecoration(labelText: 'Birthday'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your birthday';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
