import 'dart:convert';

import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/common_widget/round_textfield.dart';
import 'package:fitness/main.dart';
import 'package:fitness/view/home/home_view.dart';
import 'package:fitness/view/login/complete_profile_view.dart';
import 'package:fitness/view/login/signup_view.dart';
import 'package:fitness/view/main_tab/main_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isCheck = false;
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final storage = FlutterSecureStorage();

 Future<bool> _checkEmailExists(String email) async {
  final response = await http.post(
    Uri.parse('https://runningappapi.onrender.com/api/Authentication/IsEmailExist'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'email': email,
    }),
  );

  if (response.statusCode == 200) {
    return response.body.toLowerCase() == 'true';
  } else {
    return false;
  }
}

  Future<void> _login() async {
  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
    // Handle empty email or password
    // _showNotification('Error', 'Please enter both email and password');
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    // First, check if the email exists in the database
    final emailExists = await _checkEmailExists(_emailController.text);
    if (!emailExists) {
      // If the email does not exist, handle the error
      // _showNotification('Error', 'Email does not exist');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // If the email exists, proceed with the login
    final response = await http.post(
      Uri.parse('https://runningappapi.onrender.com/api/Authentication/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final token = jsonData['token'];
      final userId = jsonData['userId'];

      await storage.write(key: 'token', value: token);
      // Update the global state with the userId
      Provider.of<GlobalState>(context, listen: false).updateUserId(userId);

      // Navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainTabView()),
      );
    } else {
      // Handle login failure
      print('Login failed: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Invalid email or password');
      // _showNotification('Error', 'Invalid email or password');
    }
  } catch (e) {
  // Handle general error
  print('Error occurred: $e');
  if (e is Error) {
    print('Stack trace: ${e.stackTrace}');
  }
  throw Exception('An error occurred: $e');
}
}

// void _showNotification(String title, String message) {
//   Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 1,
//     backgroundColor: Colors.red,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: media.height * 0.9,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hey there,",
                  style: TextStyle(color: TColor.gray, fontSize: 16),
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hitText: "Email",
                  icon: "assets/img/email.png",
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                RoundTextField(
                  hitText: "Password",
                  icon: "assets/img/lock.png",
                  obscureText: !_isPasswordVisible,
                  controller: _passwordController,
                  rigtIcon: TextButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        _isPasswordVisible
                            ? "assets/img/hide_password.png"
                            : "assets/img/show_password.png",
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                        color: TColor.gray,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 16), // adjust the value as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot your password?",
                        style: TextStyle(
                            color: TColor.gray,
                            fontSize: 10,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                RoundButton(
                    title: "Login",
                    onPressed: _login,
                ),
                    // onPressed: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => const MainTabView()));
                    // }),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                    Text(
                      "  Or  ",
                      style: TextStyle(color: TColor.black, fontSize: 12),
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          "assets/img/google.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: media.width * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          "assets/img/facebook.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpView()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don’t have an account yet? ",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Register",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
