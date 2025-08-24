import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_firebase_app/app/controllers/auth_controller.dart';
import 'package:my_firebase_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home View'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () => authC.logout(), icon: Icon(Icons.logout)),
        ],
      ),
      // =======================================================================
      // ONETIME GET DATA FROM FIREBASE :
      // =======================================================================
      // body: FutureBuilder<QuerySnapshot<Object?>>(
      //   future: controller.getData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       var listAllDocument = snapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: listAllDocument.length,
      //         itemBuilder:
      //             (context, index) => ListTile(
      //               title: Text(
      //                 'Nama product: ${(listAllDocument[index].data() as Map<String, dynamic>)["name"]}',
      //               ),
      //               subtitle: Text(
      //                 'Harga product: ${(listAllDocument[index].data() as Map<String, dynamic>)["price"]}',
      //               ),
      //             ),
      //       );
      //     }
      //     return Center(child: CircularProgressIndicator());
      //   },
      // ),
      // =======================================================================
      // REALTIME GET DATA FROM FIREBASE :
      // =======================================================================
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocument = snapshot.data!.docs;
            return ListView.builder(
              itemCount: listAllDocument.length,
              itemBuilder:
                  (context, index) => ListTile(
                    onTap:
                        () => Get.toNamed(
                          Routes.EDIT_PRODUCT,
                          arguments: listAllDocument[index].id,
                        ),
                    title: Text(
                      'Nama product: ${(listAllDocument[index].data() as Map<String, dynamic>)["name"]}',
                    ),
                    subtitle: Text(
                      'Harga product: ${(listAllDocument[index].data() as Map<String, dynamic>)["price"]}',
                    ),
                  ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_PRODUCT);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
