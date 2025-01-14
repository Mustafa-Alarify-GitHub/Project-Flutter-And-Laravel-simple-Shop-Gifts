import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutter/material.dart';

class CustomButtonDrawer extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;

  const CustomButtonDrawer(
      {super.key, required this.text, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Icon(
                  icon,
                  size: 30,
                  color: ColorApp.white,
                )),
            Expanded(
                flex: 3,
                child: Text(
                  text,
                  style: const TextStyle(color: ColorApp.white, fontSize: 18),
                ))
          ],
        ),
      ),
    );
  }
}
