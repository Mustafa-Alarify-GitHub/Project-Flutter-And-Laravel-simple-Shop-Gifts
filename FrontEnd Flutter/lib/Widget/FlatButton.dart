import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutter/material.dart';

class FlatButton extends StatelessWidget {
  const FlatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: ColorApp.backgroundDark,
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: ColorApp.white,width: 5)
      ),
      child: const Icon(
        Icons.add_shopping_cart,
        color: ColorApp.white,
        size: 34,
      ),
    );
  }
}
