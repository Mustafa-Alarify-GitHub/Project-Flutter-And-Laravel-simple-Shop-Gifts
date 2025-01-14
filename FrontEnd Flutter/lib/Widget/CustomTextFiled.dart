import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextEditingController controller;

  const CustomTextFiled({super.key, required this.hintText, required this.icon, required this.obscureText, required this.controller});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: TextField(
        controller:controller,
        obscureText:obscureText ,
        decoration: InputDecoration(
            fillColor: ColorApp.white,
            filled: true,
            hintText: hintText,
            suffixIcon: Icon(icon),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
