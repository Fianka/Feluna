import 'package:get/get.dart';

import '../controllers/treatment_olahnafas_controller.dart';

class TreatmentOlahnafasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TreatmentOlahnafasController>(
      () => TreatmentOlahnafasController(),
    );
  }
}
