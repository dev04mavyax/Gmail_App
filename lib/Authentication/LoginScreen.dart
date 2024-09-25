import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gmailapp/Authentication/CreateAccount.dart';
import 'package:gmailapp/Authentication/ForgotPassword.dart';
import 'package:gmailapp/Home/HomeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool stayLoggedIn = false; // For "Stay logged in" option

  Future<void> loginUser() async {
    final url = 'http://192.168.0.111:4000/api/app/app-login'; // Backend URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      final responseBody = json.decode(response.body);

      if (response.statusCode == 200) {
        print('Login successful: ${response.body}');

        // Retrieve email, mail password, and token from response
        String email = responseBody['userInfo']['email'] ?? "";
        String mailPassword = responseBody['userInfo']['mailPassword'] ?? "";
        String token = responseBody['token'] ?? ""; // Assuming your backend returns a JWT or token

        // Store email, mailPassword, and token in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('email', email);
        await prefs.setString('mailPassword', mailPassword);

        if (stayLoggedIn) {
          // Store the token for session management
          await prefs.setString('token', token);
        }

        // Navigate to the home screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GmailHomePage(
              email: email,
              password: mailPassword,
            ),
          ),
        );
      } else if (response.statusCode == 404 &&
          responseBody['message'] == "User doesn't exist") {
        _showDialog('User Not Found',
            'The email you entered does not belong to an account. Please check your email or sign up.');
      } else {
        final errorMessage =
            responseBody['message'] ?? 'Login failed. Please try again.';
        _showDialog('Login Failed', errorMessage);
      }
    } catch (e) {
      print('Error: $e');
      _showDialog('Network Error', 'Please check your connection and try again.');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // Check if user is already logged in using the token
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      // If token exists, navigate to home screen (validate token with backend if needed)
      String email = prefs.getString('email') ?? "";
      String mailPassword = prefs.getString('mailPassword') ?? "";

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GmailHomePage(
            email: email,
            password: mailPassword,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // Check login status on app startup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                'EaseSmith',
                style: GoogleFonts.aBeeZee(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'with your Google Account.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  // Handle Learn More action
                },
                child: Text(
                  'Learn more about using your account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'Email or phone',
                        hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w400),
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade200)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w400),
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Checkbox(
                    value: stayLoggedIn,
                    onChanged: (bool? value) {
                      setState(() {
                        stayLoggedIn = value ?? false;
                      });
                    },
                  ),
                  Text('Stay logged in'),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  );

                  // Handle Forgot email action
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Forgot email?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 200),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 110,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            loginUser();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            minimumSize: Size(double.infinity, 50),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
