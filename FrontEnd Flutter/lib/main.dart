import 'package:flutterbalal/Screen/Home/Home.dart';
import 'package:flutterbalal/Screen/SplachScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // home: Home()
      home: Splachscreen()
    );
  }
}
