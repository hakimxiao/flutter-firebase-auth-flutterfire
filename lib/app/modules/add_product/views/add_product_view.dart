import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ADD PRODUCT'), centerTitle: true),
      body: Padding(
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
                  () => controller.add(
                    controller.nameC.text,
                    controller.priceC.text,
                  ),
              child: Text('ADD PRODUCT'),
            ),
          ],
        ),
      ),
    );
  }
}
