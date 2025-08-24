import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void add(String name, String price) async {
    CollectionReference products = firestore.collection(
      'products',
    ); // refer ke collection products

    try {
      String dateNow = DateTime.now().toString();
      await products.add({
        'name': name,
        'price': int.parse(price),
        "time": dateNow,
      });
      Get.defaultDialog(
        title: 'Berhasil',
        middleText: 'Berhasil menambahkan product $name',
        onConfirm: () {
          nameC.clear();
          priceC.clear();
          Get.back(); // close defaultDialog
          Get.back(); // back toHome
        },
        textConfirm: 'OKAY',
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Tidak berhasil menambahkan product',
      );
    }
  }

  @override
  void onInit() {
    nameC = TextEditingController();
    priceC = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    nameC.dispose();
    priceC.dispose();
    super.onClose();
  }
}
