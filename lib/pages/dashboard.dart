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

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                            Text(
                                "Mail Name:  ${auth.currentUser!.displayName}"),
                            Text(finalData["phone"]),
                            Text(auth.currentUser!.email.toString()),
                            ElevatedButton(
                                onPressed: () {
                                  print(box.read('email'));
                                },
                                child: Text("read data"))
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
      ),
    ));
  }
}
