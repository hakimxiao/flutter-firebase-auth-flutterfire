import 'package:get/get.dart';

import '../controllers/query_controller.dart';

class QueryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QueryController>(
      () => QueryController(),
    );
  }
}
