import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_firebase_app/app/controllers/auth_controller.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  ResetPasswordView({super.key});

  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: controller.emailC,
              decoration: InputDecoration(label: Text('Email')),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => authC.resetPassword(controller.emailC.text),
              child: Text("RESET"),
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
