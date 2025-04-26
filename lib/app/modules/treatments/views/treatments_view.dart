import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/treatments_controller.dart';

class TreatmentsView extends GetView<TreatmentsController> {
  const TreatmentsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TreatmentsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TreatmentsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
