import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // One time read
  // Future<QuerySnapshot<Object?>> getData() async {
  //   CollectionReference products = firestore.collection('products');

  //   return products.get();
  // }
  // ===========================================================================
  // Real time read
  Future<QuerySnapshot<Object?>> getData() async {
    CollectionReference products = firestore.collection('products');

    return products.get();
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference products = firestore.collection('products');
    return products.orderBy('time', descending: true).snapshots();
  }

  void deleteProduct(String docId) async {
    DocumentReference product = firestore.collection('products').doc(docId);

    try {
      Get.defaultDialog(
        title: 'Delete Data',
        middleText: 'Apakah Kamu yakin Ingin Menghapus Data Ini',
        onConfirm: () async {
          await product.delete();
          Get.back();
        },
        textConfirm: "YES",
        textCancel: "NO",
      );
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Get.defaultDialog(
        title: 'Terjadi Kesalahan',
        middleText: 'Gagal Menghapus Data Ini',
      );
    }
  }
}
