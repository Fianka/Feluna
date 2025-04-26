import 'package:get/get.dart';

import '../modules/akun/bindings/akun_binding.dart';
import '../modules/akun/views/login_view.dart';
import '../modules/calendar/bindings/calendar_binding.dart';
import '../modules/calendar/views/calendar_view.dart';
import '../modules/chatbot/bindings/chatbot_binding.dart';
import '../modules/chatbot/views/chatbot_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/treatment_olahnafas/bindings/treatment_olahnafas_binding.dart';
import '../modules/treatment_olahnafas/views/treatment_olahnafas_view.dart';
import '../modules/treatment_peregangan/bindings/treatment_peregangan_binding.dart';
import '../modules/treatment_peregangan/views/treatment_peregangan_view.dart';
import '../modules/treatments/bindings/treatments_binding.dart';
import '../modules/treatments/views/treatments_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CALENDAR,
      page: () => const CalendarView(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.TREATMENT,
      page: () => const TreatmentView(),
      binding: TreatmentBinding(),
    ),
    GetPage(
      name: _Paths.TREATMENT_PEREGANGAN,
      page: () => const TreatmentPereganganView(),
      binding: TreatmentPereganganBinding(),
    ),
    GetPage(
      name: _Paths.TREATMENT_OLAHNAFAS,
      page: () => const TreatmentOlahnafasView(),
      binding: TreatmentOlahnafasBinding(),
    ),
    GetPage(
      name: _Paths.CHATBOT,
      page: () => const ChatbotView(),
      binding: ChatbotBinding(),
    ),
    GetPage(
      name: _Paths.TREATMENTS,
      page: () => const TreatmentsView(),
      binding: TreatmentsBinding(),
    ),
    GetPage(
      name: _Paths.AKUN,
      page: () => const AkunView(),
      binding: AkunBinding(),
    ),
  ];
}
