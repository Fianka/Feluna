import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/treatment_olahnafas_controller.dart';

class TreatmentOlahnafasView extends GetView<TreatmentOlahnafasController> {
  const TreatmentOlahnafasView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TreatmentOlahnafasView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TreatmentOlahnafasView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
