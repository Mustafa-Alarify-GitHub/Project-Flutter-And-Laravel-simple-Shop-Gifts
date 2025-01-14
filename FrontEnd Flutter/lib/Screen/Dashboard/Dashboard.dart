import 'package:flutterbalal/Screen/Dashboard/AddCatogray.dart';
import 'package:flutterbalal/Screen/Dashboard/AddGift.dart';
import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutterbalal/Widget/CustomAppBar.dart';
import 'package:flutterbalal/Widget/CustomButtonDrawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Dashboard"),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: EdgeInsets.all(5),
            color: ColorApp.backgroundDark,
            child: CustomButtonDrawer(
                onTap: () {
                  Get.to(() => Addcatogray());
                },
                text: "Add Catogrey",
                icon: Icons.category_rounded),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            padding: EdgeInsets.all(5),
            color: ColorApp.backgroundDark,
            child: CustomButtonDrawer(
                onTap: () {
                  Get.to(() => AddGift());
                },
                text: "Add Gifts",
                icon: Icons.card_giftcard_outlined),
          )
        ],
      ),
    );
  }
}
