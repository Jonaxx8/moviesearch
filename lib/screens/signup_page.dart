import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  void registerUser() async {
  if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
    var regBody = {
      "email": emailController.text,
      "password": passwordController.text
    };

    try {
      var response = await http.post(
        Uri.parse(registration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey('status')) {
          if (jsonResponse['status']) {
            // User registration successful
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          } else {
            // Registration failed
            print("Something Went Wrong");
          }
        } else {
          print("Unexpected response format. 'status' key not found.");
        }
      } else {
        print('Error: ${response.statusCode}');
        // Handle non-200 status code appropriately
      }
    } catch (error) {
      print('Error sending HTTP request: $error');
    }
  } else {
    setState(() {
      _isNotValidate = true;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up Page',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                  errorText: _isNotValidate ? "Enter Proper Info" : null,
                  errorStyle: const TextStyle(color: Colors.white),
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorStyle: const TextStyle(color: Colors.white),
                  errorText: _isNotValidate ? "Enter Proper Info" : null,
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerUser,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
