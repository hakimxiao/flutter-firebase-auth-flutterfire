// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QueryController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void filter(int age) async {
    // memfilter pas pada kondisi nama = joni dst
    final result =
        // EXAMPLE 1 :
        // await firestore.collection('users').orderBy('name').startAt([
        //   'miko',
        // ]) // mulai dari miko sampai selesai didata, sebelum miko di skip
        // .get();
        // EXAMPLE 2 :
        await firestore
            .collection('users')
            .orderBy('name')
            .startAt(['miko'])
            .endAt(['sumanto'])
            .get();

    if (result.docs.isNotEmpty) {
      print('Total data : ${result.docs.length}');
      for (var element in result.docs) {
        var id = element.id;
        var data = element.data();

        print('ID : $id');
        print('Data : $data');
      }
    } else {
      print('Tidak ada data yang sesuai');
    }
  }
}
