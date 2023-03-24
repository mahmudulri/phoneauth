import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_auth/pages/dashboard.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController phoneController = TextEditingController();

  // Future sendData() async {
  //   final db = await FirebaseFirestore.instance.collection("User-info").add({
  //     "mailAddress": "",
  //     "Name": "",
  //     "address": "",
  //     "phoneNumber": "",
  //   });
  // }

  Future<bool?> signInWithGoogle() async {
    bool result = false;
    final box = GetStorage();

    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection("User-info").doc(user!.email).set({
            "name": "Mahmudul Hasan",
            "uid": user.uid,
            "phone": "01701987948",
            "email": user.email,
          });
          box.write('email', user.email);
          print(box.read('email'));
        }
        result = true;
        box.write('email', "already_signged_in");

        Get.to(() => UserDashBoard());
      }
      return result;
    } catch (e) {
      print(e);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      signInWithGoogle();
                    });
                  },
                  child: Text("Sign in with Google"))
            ],
          ),
        ),
      ),
    ));
  }
}
