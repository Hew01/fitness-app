import 'dart:convert';

import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common/common.dart';
import 'package:fitness/view/login/what_your_goal_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import 'package:fitness/controllers/api_service.dart';
import 'package:http/http.dart' as http;

import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class ApiService {
  // ...

  Future<void> registerUser(String email, String password) async {
    final url = Uri.parse('https://runningappapi.onrender.com/api/register');
    final response = await http.post(url, headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode({
      'email': email,
      'password': password,
      // 'name': name,
    }));

    if (response.statusCode == 201) {
      // Registration successful
      return;
    } else {
      // Handle registration error
      throw Exception('Failed to register user');
    }
  }
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtWeight = TextEditingController();
  TextEditingController txtHeight = TextEditingController();
  String _selectedGender = "Choose Gender";
  final ApiService _apiService = ApiService();
  dynamic _data;

  Future<dynamic> fetchData(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/img/complete_profile.png",
                  width: media.width,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  "Let’s complete your profile",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "It will help us to know more about you!",
                  style: TextStyle(color: TColor.gray, fontSize: 12),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     await fetchData(
                //         'https://runningappapi.onrender.com/api/InitialData'); // replace 'your_url' with the actual URL
                //   },
                //   child: Text('Fetch Data'),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: TColor.lightGray,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 50,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Image.asset(
                                "assets/img/gender.png",
                                width: 20,
                                height: 20,
                                fit: BoxFit.contain,
                                color: TColor.gray,
                              ),
                            ),
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  items: ["Male", "Female"]
                                      .map((name) => DropdownMenuItem(
                                            value: name,
                                            child: Text(
                                              name,
                                              style: TextStyle(
                                                  color: TColor.gray,
                                                  fontSize: 14),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                  isExpanded: true,
                                  hint: Text(
                                    _selectedGender,
                                    style: TextStyle(
                                        color: TColor.gray, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      DateTimeFormField(
                        decoration: InputDecoration(
                          filled: true, // Add this line
                          fillColor: TColor.lightGray,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none, // Add this line
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none, // Add this line
                          ),
                          hintText: "Date of Birth",
                          suffixIcon: Container(
                            width: 0,
                          ),
                          prefixIcon: Container(
                            alignment: Alignment.center,
                            width: 20,
                            height: 20,
                            child: Image.asset(
                              "assets/img/date.png",
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                              color: TColor.gray,
                            ),
                          ),
                          hintStyle:
                              TextStyle(color: TColor.gray, fontSize: 12),
                        ),
                        mode: DateTimeFieldPickerMode.date,
                        onSaved: (date) {
                          setState(() {
                            txtDate.text = date != null
                                ? DateFormat('yyyy-MM-dd').format(date)
                                : '';
                          });
                        },
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextField(
                              controller: txtDate, // Keep this for date input
                              hitText: "Your Weight",
                              icon: "assets/img/weight.png",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: TColor.secondaryG,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "KG",
                              style:
                                  TextStyle(color: TColor.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundTextField(
                              controller:
                                  txtHeight, // Create a new controller for weight input
                              hitText: "Your Height",
                              icon: "assets/img/hight.png",
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: TColor.secondaryG,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "CM",
                              style:
                                  TextStyle(color: TColor.white, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: media.width * 0.07,
                      ),
                      RoundButton(
                          title: "Next >",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const WhatYourGoalView()));
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
