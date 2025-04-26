import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:feluna/app/data/services/chatbot_service.dart';

class ChatbotController extends GetxController {
  final TextEditingController controller = TextEditingController();
  RxList<String> messages = <String>[].obs;
  RxList<String> botMessages = <String>[].obs;
  final ChatbotService chatbotService = ChatbotService();
  RxBool isLoading = false.obs;

  // Function to send message to the chatbot
  void sendMessage() async {
    if (controller.text.isNotEmpty) {
      final userMessage = controller.text.trim();
      messages.add(userMessage);
      isLoading.value = true;
      controller.clear();

      try {
        final botResponse = await chatbotService.sendMessage(userMessage);
        botMessages.add(botResponse);
      } catch (e) {
        botMessages.add('Terjadi kesalahan: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  // Function to clear chat messages
  void clearChat() {
    messages.clear();
    botMessages.clear();
  }
}