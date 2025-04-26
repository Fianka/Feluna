import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/treatment_olahnafas_controller.dart';

class TreatmentOlahnafasView extends GetView<TreatmentOlahnafasController> {
  const TreatmentOlahnafasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tata Cara"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xFFAACBE3),
              Color(0xFFFFF3F8),
              Color(0xFFFFD0E8),
            ],
            stops: [0.0061, 0.3997, 0.994],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Petunjuk Penggunaan Olah Napas",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Ikuti langkah-langkah berikut untuk memulai latihan olah napas:",
                  ),
                  const SizedBox(height: 10),
                  const _InstructionsList(),
                  const SizedBox(height: 10),
                  const Text(
                    "Catatan: Jika merasa pusing atau tidak nyaman, segera berhenti dan beristirahat.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 248, 117, 117),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.startBreathingSession(5); // contoh loop
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        "Mulai",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InstructionsList extends StatelessWidget {
  const _InstructionsList();

  @override
  Widget build(BuildContext context) {
    final instructions = [
      "Cari tempat yang nyaman dan tenang.",
      "Duduk dengan posisi punggung tegak namun rileks.",
      "Masukkan jumlah berapa kali anda ingin melakukan olah napas di kolom \"Jumlah\".",
      "Pilih musik pendamping jika anda ingin pengalaman yang lebih baik.",
      "Atur volume musik dan suara denting sesuai keinginan anda.",
      "Klik \"Play\" untuk memulai olah napas.",
      "Ikuti pergerakan titik atau suara denting untuk melakukan pergerakan \"Tarik\", \"Hembuskan\", dan \"Tahan\".",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        instructions.length,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text("${index + 1}. ${instructions[index]}"),
        ),
      ),
    );
  }
}
