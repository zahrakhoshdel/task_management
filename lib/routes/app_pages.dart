// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:task_management/screens/authentication/authentication_bindings.dart';
import 'package:task_management/screens/authentication/signin_screen.dart';
import 'package:task_management/screens/authentication/signup_screen.dart';
import 'package:task_management/screens/home/home_binding.dart';
import 'package:task_management/screens/home/home_screen.dart';
import 'package:task_management/screens/tasks/task_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => SignInScreen(),
      binding: AuthenticationBindings(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpScreen(),
      binding: AuthenticationBindings(),
    ),
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
