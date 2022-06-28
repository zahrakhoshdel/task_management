import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/home/home_controller.dart';
import 'package:task_management/screens/tasks/task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return SafeArea(
        child: Scaffold(
          body: TaskScreen(),
          floatingActionButton: FloatingActionButton.extended(
            label: const Text("Add Task"),
            icon: const Icon(Icons.add),
            backgroundColor: AppColors.primaryColor,
            onPressed: () async {
              await controller.addTaskDialog('Add task');
            },
          ),
        ),
      );
    });
  }
}
