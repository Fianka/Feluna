import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/treatment_peregangan_controller.dart';

class TreatmentPereganganView extends GetView<TreatmentPereganganController> {
  const TreatmentPereganganView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TreatmentPereganganView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TreatmentPereganganView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
