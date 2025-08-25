import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/query_controller.dart';

class QueryView extends GetView<QueryController> {
  const QueryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Query Pada Firebase'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => controller.filter(21),
          child: Text('FIlter', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
