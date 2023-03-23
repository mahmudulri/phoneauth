import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_auth/pages/dashboard.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController phoneController = TextEditingController();

  phoneAuth() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        var result = await _auth.signInWithCredential(credential);
        var user = result.user;
        if (user != null) {
          Get.to(() => UserDashBoard());
        }
      },
      verificationFailed: (FirebaseAuthException exception) async {
        print(exception.toString());
      },
      codeSent: (String verificationID, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
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
              Container(
                height: 60,
                width: screenWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintText: "Enter Number",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    phoneAuth();
                  },
                  child: Text("Sign Up Now"))
            ],
          ),
        ),
      ),
    ));
  }
}
