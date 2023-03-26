import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_auth/newpages/new_products_page.dart';
import 'package:phone_auth/pages/productpage.dart';

class NewUserDashBoard extends StatefulWidget {
  NewUserDashBoard({super.key});

  @override
  State<NewUserDashBoard> createState() => _NewUserDashBoardState();
}

class _NewUserDashBoardState extends State<NewUserDashBoard> {
  final auth = FirebaseAuth.instance;

  final database = FirebaseFirestore.instance;
  final box = GetStorage();

  // @override
  // void initState() {
  //   checkProfile();
  //   super.initState();
  // }

  // checkProfile() {
  //   print(box.read('name'));
  //   if (box.read('name') == "noname") {
  //     print("please enter your name");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.blue,
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
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              "assets/images/logo.png",
                              height: 150,
                              width: screenWidth,
                            ),
                            Divider(
                              thickness: 2,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: screenHeight * 0.020,
                            ),
                            Text(
                              "Name : " + finalData["name"],
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            // Text(
                            //     "Mail Name:  ${auth.currentUser!.displayName}"),
                            Text(
                              "Phone : " + finalData["phone"],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Email : " + auth.currentUser!.email.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Update Profile"),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Divider(
              thickness: 2,
              color: Colors.white,
            ),
            SizedBox(
              height: screenHeight * 0.080,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "01984150572",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            setState(() {
              box.write('name', "noname");
            });
          },
          child: Text(
            "Fresh Clothes",
            style: GoogleFonts.oswald(
              fontSize: 18,
            ),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => NewProductpage());
              },
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/mens.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Mens Items",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          ///   2nd.......................//2nd
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/mens.png",
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Womens Item",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/mens.png",
                  ),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Household Item	",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
