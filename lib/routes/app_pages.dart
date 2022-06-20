// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:task_management/screens/home/home_binding.dart';
import 'package:task_management/screens/home/home_screen.dart';
import 'package:task_management/screens/tasks/task_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TASKS,
      page: () => TaskScreen(),
    ),
  ];
}
