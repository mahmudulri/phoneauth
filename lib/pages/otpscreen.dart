import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Enter otp"),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed: () {}, child: Text("Submit")),
          ],
        ),
      ),
    ));
  }
}
