import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarController extends GetxController {
  // Menstruation Data
  RxList<DateTime> menstruationDates = <DateTime>[].obs;
  RxList<List<DateTime>> menstruationPeriods = <List<DateTime>>[].obs;
  RxSet<DateTime> selectedDays = <DateTime>{}.obs;

  // Stats
  RxInt averageCycleLength = 28.obs;
  RxDouble averageDuration = 5.0.obs;
  RxBool hasLongDuration = false.obs;
  RxBool hasLongCycle = false.obs;
  RxBool isMenstruationTomorrow = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMenstruationDates(); // Load data when the controller is initialized
  }

  // Load menstruation dates from SharedPreferences
  Future<void> loadMenstruationDates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? menstruationDatesString = prefs.getStringList('menstruationDates');
    if (menstruationDatesString != null && menstruationDatesString.isNotEmpty) {
      menstruationDates.value = menstruationDatesString.map((e) => DateTime.parse(e)).toList();
      menstruationDates.sort((a, b) => a.compareTo(b));
      groupMenstruationDates();
      calculateAverageCycleAndDuration();
      checkAbnormalPeriods();
    }
  }

  // Save menstruation dates to SharedPreferences
  Future<void> saveMenstruationDates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> menstruationDatesList = menstruationDates.map((e) => e.toIso8601String()).toList();
    await prefs.setStringList('menstruationDates', menstruationDatesList);
  }

  // Group menstruation dates into periods
  void groupMenstruationDates() {
    menstruationPeriods.clear();
    if (menstruationDates.isEmpty) return;

    List<DateTime> currentPeriod = [menstruationDates[0]];
    for (int i = 1; i < menstruationDates.length; i++) {
      if (menstruationDates[i].difference(menstruationDates[i - 1]).inDays == 1) {
        currentPeriod.add(menstruationDates[i]);
      } else {
        menstruationPeriods.add(currentPeriod);
        currentPeriod = [menstruationDates[i]];
      }
    }
    menstruationPeriods.add(currentPeriod);
  }

  // Calculate average cycle length and duration
  void calculateAverageCycleAndDuration() {
    if (menstruationPeriods.isNotEmpty) {
      double totalDuration = 0;
      for (var period in menstruationPeriods) {
        totalDuration += period.length;
      }
      averageDuration.value = totalDuration / menstruationPeriods.length;
    }

    if (menstruationDates.length >= 2) {
      List<int> cycleLengths = [];
      for (int i = 1; i < menstruationDates.length; i++) {
        cycleLengths.add(menstruationDates[i].difference(menstruationDates[i - 1]).inDays);
      }
      averageCycleLength.value = (cycleLengths.reduce((a, b) => a + b) / cycleLengths.length).round();
    }

    checkAbnormalPeriods();
  }

  // Check for abnormal periods
  void checkAbnormalPeriods() {
    if (menstruationPeriods.isNotEmpty) {
      List<DateTime> latestPeriod = menstruationPeriods.last;
      int latestDuration = latestPeriod.length;

      hasLongDuration.value = latestDuration > 16;

      if (menstruationDates.length >= 2) {
        int cycleLength = menstruationDates.last.difference(menstruationDates[menstruationDates.length - 2]).inDays;
        hasLongCycle.value = cycleLength > 50;
      }
    }

    // Predict if menstruation is tomorrow
    if (menstruationDates.isNotEmpty) {
      DateTime tomorrow = DateTime.now().add(Duration(days: 1));
      isMenstruationTomorrow.value = menstruationDates.any((date) => isSameDay(date, tomorrow));
    }
  }

  // Toggle selection for a day
  void toggleDaySelection(DateTime day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
    saveMenstruationDates(); // Save the updated dates
  }

  // Utility function to check if two dates are the same day
  bool isSameDay(DateTime day1, DateTime day2) {
    return day1.year == day2.year && day1.month == day2.month && day1.day == day2.day;
  }
}