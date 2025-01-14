import 'dart:convert';
import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutterbalal/Widget/CardProduct.dart';
import 'package:flutterbalal/Widget/CustomAppBar.dart';
import 'package:flutterbalal/Widget/CustomButtonCatogry.dart';
import 'package:flutterbalal/Widget/CustomDrawer.dart';
import 'package:flutterbalal/Widget/CustomTextFiled.dart';
import 'package:flutterbalal/Widget/FlatButton.dart';
import 'package:flutterbalal/Widget/NavgationButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/LinkApp.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> dataProduct = [];
  List<dynamic> dataCatogrey = [];
  bool isLoading = true;
  int? selectedCategoryId;
  List<int> favoriteProductIds = [];
  int? userId;

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? storedUserId = prefs.getInt('user_id');
    setState(() {
      userId = storedUserId;
    });
    print("ssssssss User ID: $storedUserId");
  }

  Future<void> fetchData([int? categoryId]) async {
    try {
      print("mmmmmmmmmmmmmmmmmmm");
      print(favoriteProductIds);
      print("mmmmmmmmmmmmmmmmmmm");
      String url = '${LinkApp.server}/getgifts';
      if (categoryId != null) {
        url += '?category_id=$categoryId';
      }
      if (userId != null) {
        url += (categoryId != null ? '&' : '?') + 'user_id=$userId';
      }

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        setState(() {
          dataProduct = List.from(data['gifts']);
          dataCatogrey = List.from(data['categories']);
          favoriteProductIds = List.from(data['favorites']).cast<int>();
          // favoriteProductIds = data['favorites'].map<int>((e) => e['gift_id']).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserId();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    return Scaffold(
      appBar: CustomAppBar("هديتي"),
      backgroundColor: Colors.grey[200],
      drawer: const CustomDrawer(),
      floatingActionButton: FlatButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            CustomTextFiled(
              hintText: "Search Here ...",
              icon: Icons.search,
              obscureText: false,
              controller: search,
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomButtonCatogry(
                    text: "All",
                    onTap: () {
                      setState(() {
                        fetchData();
                      });

                    },
                  ),
                  ...List.generate(
                    dataCatogrey.length,
                        (index) => CustomButtonCatogry(
                      text: "${dataCatogrey[index]["name"]}",
                      onTap: () {
                        setState(() {
                          selectedCategoryId =
                          dataCatogrey[index]["id"];
                        });
                        fetchData(selectedCategoryId);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: GridView.builder(
                  itemCount: dataProduct.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: 350,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    bool isFavorite = favoriteProductIds.contains(dataProduct[index]["id"]);
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorApp.white,
                      ),
                      child: CardProduct(
                        id: dataProduct[index]["id"],
                        name: "${dataProduct[index]["name"]}",
                        img: "http://192.168.1.7:8000${dataProduct[index]["image"]}",
                        price: "${dataProduct[index]["price"]}",
                        isFavorite: isFavorite,
                        userId: userId!,
                      ),
                    );
                  },
                ),
              ),
            ),
            NavgationButton(),
          ],
        ),
      ),
    );
  }
}

