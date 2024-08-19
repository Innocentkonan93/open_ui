// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/cards/bindings/cards_binding.dart';
import '../modules/cards/views/cards_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CARDS;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CARDS,
      page: () => const CustomTextField(),
      binding: CardsBinding(),
    ),
  ];
}
