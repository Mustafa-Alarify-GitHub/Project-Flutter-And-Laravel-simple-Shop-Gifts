import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CardProduct extends StatefulWidget {
  final int id;
  final String name;
  final String img;
  final String price;
  final bool isFavorite;
  final int userId;

  const CardProduct({
    super.key,
    required this.id,
    required this.name,
    required this.img,
    required this.price,
    required this.isFavorite, required this.userId,
  });

  @override
  _CardProductState createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  bool? isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  Future<void> toggleFavorite(int productId, int userId) async {
    try {
      print("5555555555555555555555555");
      final response = await http.post(
        Uri.parse('http://192.168.1.7:8000/api/add-to-favorites'),
        body: {
          'gift_id': productId.toString(),
          'user_id': userId.toString(),
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          isFavorite = !isFavorite!;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isFavorite! ? 'تمت إضافة المنتج للمفضلة' : 'تم إزالة المنتج من المفضلة')),
        );
      } else {
        throw Exception('فشل في تحديث المفضلة');
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('حدث خطأ أثناء إضافة/إزالة المنتج من المفضلة')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            flex: 2,
            child: Image.network(
              widget.img,
              width: 200,
              fit: BoxFit.contain,
            )),
        Expanded(
            flex: 1,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 20),
                ),
                Text("${widget.price} ر.ي "),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorite! ? Icons.favorite : Icons.favorite_border_outlined,
                        color: isFavorite! ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => toggleFavorite(widget.id, widget.userId),
                    ),
                    Icon(Icons.shopping_cart_checkout_outlined),
                  ],
                )
              ],
            ))
      ],
    );
  }
}







// class CardProduct extends StatelessWidget {
//   final int id;
//   final String name;
//   final String img;
//   final String price;
//
//   const CardProduct(
//       {super.key,
//       required this.id,
//       required this.name,
//       required this.img,
//       required this.price});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//             flex: 3,
//             child: Image.network(
//               img,
//               width: 200,
//               fit: BoxFit.contain,
//             )),
//         Expanded(
//             flex: 1,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 Text("${price} ر.ي "),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Icon(Icons.favorite_border_outlined),
//                     Icon(Icons.shopping_cart_checkout_outlined),
//                   ],
//                 )
//               ],
//             ))
//       ],
//     );
//   }
// }
