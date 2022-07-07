import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/constants/text_styles.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/tasks/task_controller.dart';
import 'package:task_management/screens/tasks/widgets/task_dialog.dart';

class TaskOperationsCard extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  final String taskId;
  TaskOperationsCard({
    Key? key,
    required this.data,
    required this.taskId,
  }) : super(key: key);

  final taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        IconButton(
          onPressed: () async => await editTaskDialog(
            'Edit task',
            TaskModel(
              id: taskId,
              title: data['title'],
              description: data['description'],
              taskDate: data['taskDate'],
              time: data['time'],
              done: data['done'],
            ),
            taskId,
          ),
          icon: const Icon(Icons.edit),
        ),
        IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Remove Task",
                contentPadding: EdgeInsets.all(size.width * 0.03),
                titleStyle: TextStyles.titleTextStyle,
                titlePadding: EdgeInsets.only(top: size.height * 0.02),
                middleText: "Do you want to delete this task?",
                middleTextStyle:
                    TextStyles.subtitleTextStyle.copyWith(fontSize: 18),
                radius: 30,
                textCancel: "Cancel",
                cancelTextColor: AppColors.primaryColor,
                textConfirm: "Delete",
                confirmTextColor: Colors.white,
                onCancel: () {
                  Get.back();
                },
                onConfirm: () {
                  deleteTask(taskId);
                  Get.back();
                },
                buttonColor: AppColors.primaryColor,
              );
            },
            icon: const Icon(Icons.delete)),
      ],
    );
  }

  editTaskDialog(String title, TaskModel task, String id) async {
    Get.defaultDialog(
      title: title,
      content: TaskDialog(task: task, id: id),
    );
  }

  void deleteTask(String id) async {
    try {
      await taskController.deleteTask(id);
    } catch (e) {
      print("Error $e");
    }
  }
}
