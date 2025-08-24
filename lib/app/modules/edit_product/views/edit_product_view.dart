import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_product_controller.dart';

class EditProductView extends GetView<EditProductController> {
  const EditProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product'), centerTitle: true),
      body: FutureBuilder<DocumentSnapshot<Object?>>(
        future: controller.getData(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            controller.nameC.text = data['name'];
            controller.priceC.text = data['price'];
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: controller.nameC,
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'Nama Product'),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: controller.priceC,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: 'Harga Product'),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed:
                        () => controller.editProduct(
                          controller.nameC.text,
                          controller.priceC.text,
                          Get.arguments,
                        ),
                    child: Text('EDIT PRODUCT'),
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
