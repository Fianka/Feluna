import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  // Reactive variables (State management)
  RxBool isLoading = false.obs;

  // Metode untuk mengirim umpan balik
  Future<void> sendFeedback(String feedback, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userIdInt = prefs.getInt('user_id');

    if (userIdInt != null) {
      String userId = userIdInt.toString();

      try {
        final response = await http.post(
          Uri.parse('https://d2ca-180-246-171-144.ngrok-free.app/feluna_db/submit_feedback.php'),
          body: {'user_id': userId, 'content': feedback},
        );

        if (response.statusCode == 200) {
          print('Umpan balik berhasil disimpan');
        } else {
          print('Gagal mengirim umpan balik');
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan saat mengirim umpan balik')),
        );
      }
    } else {
      print('User ID tidak ditemukan');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pengguna tidak terdaftar')),
      );
    }
  }

  // Metode untuk menampilkan form umpan balik
  void showFeedbackForm(BuildContext context) {
    TextEditingController feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Umpan Balik', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Kami menghargai masukan Anda. Silakan tulis umpan balik Anda di bawah ini:', style: TextStyle(fontSize: 14)),
              SizedBox(height: 15),
              TextField(
                controller: feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Tulis umpan balik Anda...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Batal')),
            ElevatedButton(
              onPressed: () {
                String feedback = feedbackController.text.trim();
                if (feedback.isNotEmpty) {
                  sendFeedback(feedback, context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Umpan balik berhasil dikirim')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Umpan balik tidak boleh kosong')));
                }
              },
              child: Text('Kirim'),
            ),
          ],
        );
      },
    );
  }

  // Metode untuk keluar dari aplikasi
  void exitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Keluar Aplikasi'),
          content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Batal')),
            TextButton(
              onPressed: () => SystemNavigator.pop(),
              child: Text('Keluar', style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }
}