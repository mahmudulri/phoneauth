import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:phone_auth/pages/dashboard.dart';
import 'package:phone_auth/pages/homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();

  checkData() async {
    var userMail = await box.read('email');

    if (userMail == null) {
      Get.to(() => Homepage());
    } else {
      Get.to(() => UserDashBoard());
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () => checkData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Text("Loading...."),
      ),
    ));
  }
}
