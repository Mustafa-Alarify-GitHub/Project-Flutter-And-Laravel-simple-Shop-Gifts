import 'dart:collection';

import 'package:flutterbalal/Screen/Auth/Login.dart';
import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutterbalal/Widget/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splachscreen extends StatefulWidget {
  @override
  State<Splachscreen> createState() => _SplachscreenState();
}

class _SplachscreenState extends State<Splachscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.primary,
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Gift",
                style: TextStyle(
                    color: ColorApp.white,
                    fontSize: 60,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                margin: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: ColorApp.white),
                child: Image.asset(
                  "assets/images/logo.png",
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 50,),
              CustomButton(
                  width: MediaQuery.of(context).size.width / 1.5,
                  color: ColorApp.button,fontSize: 24,
                  onTap: () {
                    Get.off(() => Login());
                  },
                  txt: "Start")
            ],
          ),
        ),
      ),
    );
  }
}
