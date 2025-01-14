import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double? fontSize;
  final Color color;
  final String txt;
  final void Function()? onTap;

  const CustomButton({super.key, required this.width,  this.fontSize, required this.color, required this.txt, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(40)),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(color: ColorApp.white, fontSize: fontSize ?? 40),
          ),
        ),
      ),
    );
  }
}
