import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  late TextEditingController nameC;
  late TextEditingController priceC;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = firestore.collection('products').doc(docID);
    return docRef.get();
  }

  void editProduct(String name, String price, String docID) async {
    DocumentReference product = firestore.collection('products').doc(docID);

    try {
      await product.update({'name': name, 'price': price});
      Get.defaultDialog(
        title: 'Berhasil',
        middleText: 'Berhasil mengubah data product',
        onConfirm: () {
          nameC.clear();
          priceC.clear();
          Get.back();
          Get.back();
        },
        textConfirm: 'OKAY',
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Get.defaultDialog(
        title: 'Error',
        middleText: 'Tidak berhasil mengubah data product',
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
