import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutterbalal/Widget/CustomAppBar.dart';
import 'package:flutterbalal/Widget/CustomButton.dart';
import 'package:flutterbalal/Widget/CustomTextFiled.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Utils/Api.dart';
import '../../Utils/LinkApp.dart';
import '../Home/Home.dart';

class Addcatogray extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameCatogray = TextEditingController();

    Future addcateogry() async {
      if (nameCatogray.text.isEmpty) {
        Get.snackbar("Alert", "the Name Catogray is required",backgroundColor: Colors.white);
        return;
      }
      var response = await Api.post(LinkApp.addcateogry, {
        'name': nameCatogray.text,
      });
      Get.snackbar("Alert", "${response["message"]}",backgroundColor: Colors.white);
      if (response["status"] ==200){
        Get.off(()=>Home());
      }
    }


    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar("Dashboard"),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CustomTextFiled(
              hintText: "Name Section",
              icon: Icons.add,
              obscureText: false,
              controller: nameCatogray),
          SizedBox(
            height: 40,
          ),
          CustomButton(
              onTap: addcateogry,
              fontSize: 24,
              width: MediaQuery.of(context).size.width / 1.5,
              color: ColorApp.backgroundDark,
              txt: "Add")
        ],
      ),
    );
  }
}
