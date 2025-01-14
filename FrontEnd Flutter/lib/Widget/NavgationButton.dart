import 'package:flutterbalal/Screen/Home/Favorite.dart';
import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavgationButton extends StatelessWidget {
  const NavgationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 55,
      color: ColorApp.backgroundDark,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.home_outlined,
            color: ColorApp.white,
            size: 34,
          ),
          Container(),
          InkWell(
            onTap: (){
              Get.to(()=>Favorite());
            },
            child: Icon(
              Icons.favorite_border,
              color: ColorApp.white,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }
}
