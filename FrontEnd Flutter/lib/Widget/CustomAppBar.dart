import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget CustomAppBar(String text){
  return AppBar(
    backgroundColor: ColorApp.backgroundDark,
    title: Text(text ,style: TextStyle(fontSize: 25,color: ColorApp.white),),
    centerTitle: true,
  );
}