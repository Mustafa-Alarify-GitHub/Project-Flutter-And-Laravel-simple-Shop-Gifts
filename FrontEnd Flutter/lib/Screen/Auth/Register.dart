import 'package:flutterbalal/Screen/Auth/Login.dart';
import 'package:flutterbalal/Utils/Api.dart';
import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutterbalal/Utils/LinkApp.dart';
import 'package:flutterbalal/Widget/CustomButton.dart';
import 'package:flutterbalal/Widget/CustomTextFiled.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController userName = TextEditingController();
    TextEditingController Password = TextEditingController();
    TextEditingController email = TextEditingController();

    Future register() async {
      if (userName.text.isEmpty || Password.text.isEmpty || email.text.isEmpty) {
        Get.snackbar("Alert", "the password and name and email is required",backgroundColor: Colors.white);
        return;
      }
      var response = await Api.post(LinkApp.registerUrl, {
        'name': userName.text,
        'password': Password.text,
        'email': email.text,
      });
      print(response);
      Get.snackbar("Alert", "${response["message"]}",backgroundColor: Colors.white);
      if (response["status"] ==200){
        Get.off(()=>Login());
      }

    }

    return Scaffold(
      backgroundColor: ColorApp.primary,
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
              ),
              const SizedBox(
                height: 60,
              ),
              CustomTextFiled(
                  hintText: "User Name",
                  icon: Icons.person,
                  obscureText: false,
                  controller: userName),
              CustomTextFiled(
                  hintText: "Email",
                  icon: Icons.email,
                  obscureText: false,
                  controller: email),
              CustomTextFiled(
                  hintText: "Password",
                  icon: Icons.lock,
                  obscureText: true,
                  controller: Password),
              const SizedBox(
                height: 60,
              ),
              CustomButton(
                onTap: register,
                  width: MediaQuery.of(context).size.width * .8,
                  fontSize: 25,
                  color: ColorApp.button,
                  txt: "Sign Up"), const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.off(() => Login());
                },
                child: const Text(
                  "I Have Account Click Here",
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
