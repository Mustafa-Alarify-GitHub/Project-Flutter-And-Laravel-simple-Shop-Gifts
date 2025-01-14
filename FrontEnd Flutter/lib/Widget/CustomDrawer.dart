import 'package:flutterbalal/Screen/Dashboard/Dashboard.dart';
import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CustomButtonDrawer.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorApp.backgroundDark,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 3,
            color: ColorApp.backgroundLight,
            child: Center(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(200)),
                  child: const Icon(
                    Icons.person,
                    size: 150,
                    color: ColorApp.white,
                  )),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButtonDrawer(
              onTap: () {
                Get.to(() => Dashboard());
              },
              text: "Dashboard",
              icon: Icons.dashboard_customize_outlined),
          const CustomButtonDrawer(
              text: "Rest Password", icon: Icons.lock_outline),
          const CustomButtonDrawer(text: "About Us", icon: Icons.info_outline),
          Spacer(),
          const CustomButtonDrawer(text: "Logout", icon: Icons.logout),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
