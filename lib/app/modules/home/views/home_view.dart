import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();  // Mendapatkan instance controller

    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Keluar Aplikasi'),
            content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Batal')),
              TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Keluar', style: TextStyle(color: Colors.redAccent))),
            ],
          ),
        );
        if (shouldExit) {
          controller.exitApp(context);
        }
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => controller.showFeedbackForm(context),
                child: const Text('Feedback'),
              ),
              // ElevatedButton(
              //   onPressed: () => controller.logout(context),
              //   child: const Text('Logout'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}