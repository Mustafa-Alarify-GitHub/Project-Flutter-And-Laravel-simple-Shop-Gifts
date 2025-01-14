import 'dart:convert';

import 'package:flutterbalal/DataTest.dart';
import 'package:flutterbalal/Utils/ColorApp.dart';
import 'package:flutterbalal/Widget/CustomAppBar.dart';
import 'package:flutterbalal/Widget/CustomDrawer.dart';
import 'package:flutterbalal/Widget/FlatButton.dart';
import 'package:flutterbalal/Widget/NavgationButton.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<dynamic> dataProduct = [];
  bool isLoading = true;
 late final int userId;
  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  // Future<void> getUserId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int? storedUserId = prefs.getInt('user_id');
  //   setState(() {
  //     userId = storedUserId!;
  //   });
  //   print("rrrrrrrrUser ID: $storedUserId");
  // }

  // استرجاع المنتجات المفضلة من الـ API
  Future<void> fetchFavoriteProducts() async {
    try {
      int? userId = await getUserId();
      if (userId == null) {
        throw Exception('لم يتم العثور على معرف المستخدم');
      }
      final response = await http.get(
        Uri.parse('http://192.168.1.7:8000/api/favorites/$userId'),
        headers: {
          'Accept': 'application/json',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          dataProduct = List.from(data['favorites']);
          isLoading = false;
        });
      } else {
        throw Exception('فشل في تحميل المنتجات المفضلة');
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
    fetchFavoriteProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('المفضلة')),
      backgroundColor: Colors.grey[200],
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : dataProduct.isEmpty
          ? Center(child: Text('لا توجد منتجات مفضلة'))
          : ListView.builder(
        itemCount: dataProduct.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'http://192.168.1.7:8000${dataProduct[index]["image"]}',
                  width: 100,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      dataProduct[index]["name"],
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      "${dataProduct[index]["price"]} ر.ي",
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ],
                ),
                Icon(Icons.favorite, color: Colors.red),
              ],
            ),
          );
        },
      ),
    );
  }
}






// class Favorite extends StatelessWidget {
//   const Favorite({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar("Favorite"),
//       backgroundColor: Colors.grey[200],
//       drawer: const CustomDrawer(),
//       floatingActionButton: const FlatButton(),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 itemCount: dataProduct.length,
//                 itemBuilder: (context, index) => Container(
//                   padding: const EdgeInsets.all(4),
//                   margin: const EdgeInsets.symmetric(vertical: 5),
//                   decoration: BoxDecoration(
//                       color: ColorApp.white,
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Image.asset(
//                         dataProduct[index]["img"],
//                         width: 100,
//                       ),
//                       Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             dataProduct[index]["name"],
//                             style: const TextStyle(fontSize: 20),
//                           ),
//                           Text("${dataProduct[index]["price"]} ر.ي "
//                             ,style: const TextStyle(fontSize: 20,color: ColorApp.error)
//                             ,),
//                         ],
//                       ),
//                       const Icon(Icons.favorite_border_outlined),
//                     ],
//                   ),
//                 )),
//           ),
//           const NavgationButton()
//         ],
//       ),
//     );
//   }
// }
