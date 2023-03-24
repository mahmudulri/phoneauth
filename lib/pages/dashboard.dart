import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';

class UserDashBoard extends StatelessWidget {
  UserDashBoard({super.key});

  // TextEditingController productNameController = TextEditingController();
  // TextEditingController nameController = TextEditingController();
  // TextEditingController addressController = TextEditingController();
  // TextEditingController phoneController = TextEditingController();

  // Future sendData() async {
  //   final db = await FirebaseFirestore.instance.collection("Order-info").add({
  //     "ProductName": productNameController.text,
  //     "UserName": nameController.text,
  //     "address": addressController.text,
  //     "phoneNumber": phoneController.text,
  //     "orderID": phoneController.text.substring(7, phoneController.text.length),
  //     "status": "pending",
  //   });

  //   final userdb =
  //       await FirebaseFirestore.instance.collection("User-info").add({
  //     "UserName": nameController.text,
  //     "address": addressController.text,
  //     "phoneNumber": phoneController.text,
  //   });
  // }

  final auth = FirebaseAuth.instance;

  final database = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('User-info')
                  .where("uid", isEqualTo: auth.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      var finalData = snapshot.data!.docs[i];
                      return Column(
                        children: [
                          Text(finalData["name"]),
                          Text("Mail Name:  ${auth.currentUser!.displayName}"),
                          Text(finalData["phone"]),
                          Text(auth.currentUser!.email.toString()),
                        ],
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('categories').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  // var finalData = snapshot.data!.docs[i];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: screenHeight * 0.20,
                          width: screenWidth,
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                          child: Column(
                            children: [
                              Text(
                                snapshot.data!.docs[index]["name"],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Image.network(
                                snapshot.data!.docs[index]["image_url"],
                                height: 120,
                                width: 150,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    ));
  }
}
