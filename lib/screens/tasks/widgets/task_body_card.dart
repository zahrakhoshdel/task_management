// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/constants/text_styles.dart';
import 'package:task_management/screens/tasks/task_controller.dart';

class TaskBodyCard extends StatefulWidget {
  final Map<dynamic, dynamic> data;
  final String taskId;

  const TaskBodyCard({
    Key? key,
    required this.data,
    required this.taskId,
  }) : super(key: key);

  @override
  State<TaskBodyCard> createState() => _TaskBodyCardState();
}

class _TaskBodyCardState extends State<TaskBodyCard> {
  final taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.data['title'],
          style: TextStyles.titleTextStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.data['description'],
          style: TextStyles.subtitleTextStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(thickness: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.data['time']),
          ],
        )
      ],
    );
  }
}
