import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_auth/helpers/database_helper.dart';
import 'package:phone_auth/model/cart_model.dart';

class ViewMyCart extends StatefulWidget {
  const ViewMyCart({super.key});

  @override
  State<ViewMyCart> createState() => _ViewMyCartState();
}

class _ViewMyCartState extends State<ViewMyCart> {
  late Future<List<CartItem>> cartList;

  @override
  void initState() {
    _updateCartList();

    super.initState();
  }

  _updateCartList() {
    setState(() {
      cartList = CartDatabase.instance.getItems();
    });
  }

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: 20,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Container(
          //           color: Colors.grey,
          //           height: 80,
          //           width: screenWidth,
          //           child: Padding(
          //             padding: const EdgeInsets.symmetric(horizontal: 10),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Text(index.toString()),
          //                 Text("Product Name"),
          //                 Text("Qnty : 1"),
          //                 Text("Price : 500"),
          //               ],
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: FutureBuilder(
              future: cartList,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: 1 + snapshot.data!.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        height: 40,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Text(
                            "My Cart List",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${snapshot.data![index - 1].name}"),
                              Text("${snapshot.data![index - 1].quantity}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            height: 100,
            width: screenWidth,
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  Text("Total Items : 14"),
                  Spacer(),
                  Text(box.read("allprice").toString()),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            width: screenWidth,
            color: Colors.yellow,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Center(child: Text("Submit Order")),
            ),
          ),
        ],
      ),
    )));
  }
}
