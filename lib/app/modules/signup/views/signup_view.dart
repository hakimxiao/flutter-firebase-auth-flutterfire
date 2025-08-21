import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_firebase_app/app/controllers/auth_controller.dart';
import 'package:my_firebase_app/app/routes/app_pages.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  SignupView({super.key});

  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SignupView'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: emailC,
              decoration: InputDecoration(label: Text('Email')),
            ),
            TextField(
              controller: passwordC,
              decoration: InputDecoration(label: Text('Password')),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => authC.signup(emailC.text, passwordC.text),
              child: Text("SIGNUP"),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sudah punya akun?'),
                TextButton(onPressed: () => Get.back(), child: Text("LOGIN")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
