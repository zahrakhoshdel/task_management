import 'package:flutter/material.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/tasks/widgets/task_body_card.dart';
import 'package:task_management/screens/tasks/widgets/task_date_card.dart';
import 'package:task_management/screens/tasks/widgets/task_operations_card.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    Key? key,
    required this.data,
    required this.taskId,
  }) : super(key: key);

  final Map data;
  final String taskId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
      child: Card(
        elevation: 5,
        shadowColor: AppColors.primaryColor,
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.03),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TaskDateCard(data: data),
              ),
              Expanded(
                flex: 7,
                child: TaskBodyCard(data: data, taskId: taskId),
              ),
              Expanded(
                flex: 1,
                child: TaskOperationsCard(data: data, taskId: taskId),
              )
            ],
          ),
        ),
      ),
    );
  }
}
