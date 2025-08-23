import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  TextEditingController emailC = TextEditingController(
    text: '2022110133@students.uigm.ac.id',
  );

  @override
  void onClose() {
    emailC.dispose();
    super.onClose();
  }
}
