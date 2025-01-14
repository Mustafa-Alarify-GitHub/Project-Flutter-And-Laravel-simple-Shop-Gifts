import 'dart:convert';

import 'package:flutterbalal/Utils/Api.dart';
import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutterbalal/Widget/CustomAppBar.dart';
import 'package:flutterbalal/Widget/CustomButton.dart';
import 'package:flutterbalal/Widget/CustomTextFiled.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../Utils/LinkApp.dart';
import 'package:http/http.dart' as http;
import 'dart:io';


import '../Home/Home.dart';


class AddGift extends StatefulWidget {
  @override
  _AddGiftState createState() => _AddGiftState();
}

class _AddGiftState extends State<AddGift> {
  List<dynamic> categories = [];
  String? selectedCategory;
  TextEditingController nameGift = TextEditingController();
  TextEditingController priceGift = TextEditingController();
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response = await http.get(Uri.parse(LinkApp.cateogrys));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        categories = List.from(data['categories']);
      });
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image", backgroundColor: Colors.white);
    }
  }

  Future<void> addGift() async {
    if (selectedCategory != null && nameGift.text.isNotEmpty && priceGift.text.isNotEmpty && selectedImage != null) {
      try {
        var request = http.MultipartRequest('POST', Uri.parse(LinkApp.addgift));
        request.fields['name'] = nameGift.text;
        request.fields['price'] = priceGift.text;
        request.fields['cat_id'] = selectedCategory!;

        var stream = http.ByteStream(selectedImage!.openRead());
        var length = await selectedImage!.length();
        var filename = basename(selectedImage!.path);
        var multipartFile = http.MultipartFile('image', stream, length, filename: filename);
        request.files.add(multipartFile);
        var response = await request.send();

        if (response.statusCode == 200) {
          Get.snackbar("Alert", "Gift added successfully", backgroundColor: Colors.white);
          Get.off(() => Home());
        } else {
          Get.snackbar("Alert", "Failed to add gift", backgroundColor: Colors.white);
        }
      } catch (e) {
        Get.snackbar("Alert", "Error adding gift", backgroundColor: Colors.white);
      }
    } else {
      Get.snackbar("Alert", "All fields are required", backgroundColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: CustomAppBar("Dashboard"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextFiled(
              hintText: "Name Gift",
              icon: Icons.card_giftcard_rounded,
              obscureText: false,
              controller: nameGift,
            ),
            CustomTextFiled(
              hintText: "Price",
              icon: Icons.price_change_outlined,
              obscureText: false,
              controller: priceGift,
            ),
            const SizedBox(height: 20),

            categories.isNotEmpty
                ? DropdownButton<String>(
              isExpanded: true,
              value: selectedCategory,
              hint: Text("Select Category"),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((category) {
                return DropdownMenuItem<String>(
                  value: category['id'].toString(),
                  child: Text(category['name']),
                );
              }).toList(),
            )
                : CircularProgressIndicator(),

            const SizedBox(height: 20),


            selectedImage != null
                ? Image.file(selectedImage!, width: 100, height: 100, fit: BoxFit.cover)
                : IconButton(
              icon: Icon(Icons.image, size: 40),
              onPressed: pickImage,
            ),

            const SizedBox(height: 40),
            CustomButton(
              onTap: addGift,
              fontSize: 24,
              width: MediaQuery.of(context).size.width / 1.5,
              color: ColorApp.backgroundDark,
              txt: "Add Gift",
            ),
          ],
        ),
      ),
    );
  }
}
