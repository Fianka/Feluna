import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chatbot_controller.dart';
import 'package:feluna/app/modules/calendar/views/calendar_view.dart';
import 'package:feluna/app/modules/home/views/home_view.dart';
import 'package:feluna/app/modules/treatments/views/treatments_view.dart';

class ChatbotView extends GetView<ChatbotController> {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_chatbot.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            // Sidebar with logo and navigation icons
            Container(
              width: 80,
              color: Colors.white.withOpacity(0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/logo.png', width: 50, height: 50),
                  ),
                  const SizedBox(height: 5),
                  Column(
                    children: [
                      // Navigation icons (Home, Calendar, etc.)
                      _buildSidebarIcon(
                        icon: Icons.home,
                        label: 'Home',
                        onTap: () {
                          Get.to(() => const HomeView());
                        },
                      ),
                      _buildSidebarIcon(
                        icon: Icons.calendar_today,
                        label: 'Tracking',
                        onTap: () {
                          Get.to(() => const CalendarView());
                        },
                      ),
                      _buildSidebarIcon(
                        icon: Icons.person,
                        label: 'Treatment',
                        onTap: () {
                          Get.to(() => const TreatmentsView());
                        },
                      ),
                      _buildSidebarIcon(
                        icon: Icons.delete,
                        label: 'Clear Chat',
                        onTap: () {
                          controller.clearChat();
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
            // Main Chat Area
            Expanded(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: _buildChatMessages(),
                    ),
                  ),
                  if (controller.isLoading.value) const LinearProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.controller,
                            decoration: InputDecoration(
                              hintText: 'Type Here',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onSubmitted: (value) => controller.sendMessage(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: Colors.pink[200],
                          child: IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: controller.sendMessage,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build sidebar icons
  Widget _buildSidebarIcon({required IconData icon, required String label, required VoidCallback onTap}) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, color: const Color(0xFFD16193)),
          onPressed: onTap,
        ),
        Text(
          label,
          style: const TextStyle(color: Color(0xFFD16193), fontSize: 10),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  // Build chat messages
  List<Widget> _buildChatMessages() {
    List<Widget> chatMessages = [];
    int maxLength = controller.messages.length > controller.botMessages.length
        ? controller.messages.length
        : controller.botMessages.length;

    for (int i = 0; i < maxLength; i++) {
      if (i < controller.messages.length) {
        chatMessages.add(_buildMessage(controller.messages[i], true));
      }
      if (i < controller.botMessages.length) {
        chatMessages.add(_buildMessage(controller.botMessages[i], false));
      }
    }

    return chatMessages;
  }

  // Build individual message widget
  Widget _buildMessage(String message, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isUser ? Colors.pink[100] : Colors.pink[200],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
