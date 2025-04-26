import 'package:get/get.dart';

import '../controllers/treatment_peregangan_controller.dart';

class TreatmentPereganganBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TreatmentPereganganController>(
      () => TreatmentPereganganController(),
    );
  }
}
