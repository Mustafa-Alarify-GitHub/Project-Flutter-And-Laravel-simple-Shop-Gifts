import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtonCatogry extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CustomButtonCatogry({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        decoration: BoxDecoration(
            color: ColorApp.backgroundDark,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: const TextStyle(color: ColorApp.white, fontSize: 18),
        ),
      ),
    );
  }
}
