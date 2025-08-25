// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class QueryController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // @_Filter adalah operasi yang digunakan utnuk perbandingan,
  //  where, isEqualTo, isGreaterThan, isGreaterThanOrEqualTo, isLessThan, isLessThanOrEqualTo ...
  void filter(int age) async {
    final result =
        await firestore
            .collection('users')
            // .where('age', isEqualTo: age.toString())
            .where(
              'motor',
              whereIn: [
                ['kawasaki', 'honda'],
                ['yamaha', 'kawasaki'],
              ],
            )
            // .where('motor', arrayContains: 'yamaha')
            // .where('motor', arrayContainsAny: ['yamaha', 'honda', 'beat'])
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
