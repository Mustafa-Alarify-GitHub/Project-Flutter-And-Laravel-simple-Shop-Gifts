import 'dart:convert';

import 'package:flutterbalal/Screen/Auth/Register.dart';
import 'package:flutterbalal/Screen/Home/Home.dart';
import 'package:flutterbalal/Utils/Api.dart';
import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutterbalal/Utils/LinkApp.dart';
import 'package:flutterbalal/Widget/CustomButton.dart';
import 'package:flutterbalal/Widget/CustomTextFiled.dart';
import 'package:flutterbalal/Widget/FlatButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userName = TextEditingController();
  TextEditingController Password = TextEditingController();
  bool checked = false;

  Future<void> storeUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
    print('User ID: $userId');
  }


  Future login() async {
    if (userName.text.isEmpty || Password.text.isEmpty) {
      Get.snackbar("Alert", "The password and name are required", backgroundColor: Colors.white);
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(LinkApp.loginUrl),
        body: {
          'name': userName.text,
          'password': Password.text,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        print("Response Data: $data");

        if (data["status"] == 200) {
          if (data.containsKey("user_id") && data["user_id"] != null) {
            int userId = data["user_id"];
            print("User ID: $userId");
            storeUserId(userId);
            Get.to(() => Home());
          } else {
            Get.snackbar("Error", "User ID not found in the response", backgroundColor: Colors.white);
          }
        } else {
          Get.snackbar("Error", "Invalid credentials", backgroundColor: Colors.white);
        }
      } else {
        Get.snackbar("Error", "Failed to login", backgroundColor: Colors.white);
      }
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", "An error occurred while logging in", backgroundColor: Colors.white);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.primary,
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(200)),
                  child: const Icon(
                    Icons.person,
                    size: 150,
                    color: ColorApp.white,
                  )),
              const SizedBox(
                height: 60,
              ),
              CustomTextFiled(
                  hintText: "User Name",
                  icon: Icons.person,
                  obscureText: false,
                  controller: userName),
              CustomTextFiled(
                  hintText: "Password",
                  icon: Icons.lock,
                  obscureText: true,
                  controller: Password),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Forget Password",
                      style: TextStyle(
                          color: ColorApp.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorApp.white),
                    ),
                    Row(
                      children: [
                        const Text(
                          "Remember Me",
                          style: TextStyle(
                            color: ColorApp.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Checkbox(
                          value: checked,
                          onChanged: (value) {
                            setState(() {
                              checked = value as bool;
                            });
                            print(value);
                          },
                          side: BorderSide(color: ColorApp.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomButton(
                  onTap: login,
                  width: MediaQuery.of(context).size.width * .8,
                  fontSize: 25,
                  color: ColorApp.button,
                  txt: "LOG IN"),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.off(() => Register());
                },
                child: const Text(
                  "I don,t Have Account Click Here",
                  style: TextStyle(
                      color: ColorApp.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: ColorApp.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
