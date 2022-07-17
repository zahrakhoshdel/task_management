// ignore_for_file: void_checks

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/routes/app_pages.dart';
import 'package:task_management/screens/home/home_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Task Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      onReady: () => Get.put(() => HomeController().initNaviationListener()),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
