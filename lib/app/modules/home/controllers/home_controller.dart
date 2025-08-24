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
    return products.snapshots();
  }
}
