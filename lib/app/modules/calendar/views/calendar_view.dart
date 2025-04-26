import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:feluna/app/modules/calendar/controllers/calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends GetView<CalendarController> {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the controller directly through GetView
    final controller = Get.find<CalendarController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Menstrual Tracker")),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            selectedDayPredicate: (day) => controller.selectedDays.contains(day),
            onDaySelected: (selectedDay, focusedDay) {
              controller.toggleDaySelection(selectedDay); // Toggle day selection
            },
          ),
          Obx(() => Text("Average Cycle Length: ${controller.averageCycleLength} days")),
          Obx(() => Text("Average Duration: ${controller.averageDuration.toStringAsFixed(1)} days")),
          Obx(() {
            if (controller.hasLongCycle.value) {
              return const Text("Your cycle is longer than 50 days.");
            }
            if (controller.hasLongDuration.value) {
              return const Text("Your period duration is longer than 16 days.");
            }
            if (controller.isMenstruationTomorrow.value) {
              return const Text("Menstruation is predicted for tomorrow!");
            }
            return Container(); // Empty if no condition is met
          }),
        ],
      ),
    );
  }
}
