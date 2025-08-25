// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QueryController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // @_Filter adalah operasi yang digunakan utnuk perbandingan,
  //  where, isEqualTo, isGreaterThan, isGreaterThanOrEqualTo, isLessThan, isLessThanOrEqualTo ...
  void filter(int age) async {
    // @_Error Soliutions :  jika kita memiliki query yang duplikasi maka di firebase console nya
    //  kita wajib membuat index dahulu. agar tidak terjadi overriding.
    //  klik aja link yang error maka akan di buatkan index oleh firebase
    final result =
        await firestore
            .collection('users')
            .where('age', isLessThan: '30')
            .orderBy('age')
            // .orderBy('name', descending: true)
            .limitToLast(
              2,
            ) // 2 data paling terakhir (limitToLast) *Dia butuh orderBy setidaknya 1
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
