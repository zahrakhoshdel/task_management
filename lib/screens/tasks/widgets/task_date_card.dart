import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/constants/app_colors.dart';

class TaskDateCard extends StatelessWidget {
  final Map<dynamic, dynamic> data;

  const TaskDateCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            taskDate("d", isBold: true),
            const SizedBox(
              width: 5,
            ),
            taskDate("MMM", isBold: false),
          ],
        ),
        taskDate("E", isBold: true),
      ],
    );
  }

  Text taskDate(String format, {required bool isBold}) {
    return Text(
      DateFormat(format)
          .format(DateTime.tryParse(data['taskDate'])!)
          .toString(),
      style: isBold
          ? TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor.withOpacity(0.8),
            )
          : TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor.withOpacity(0.6),
            ),
    );
  }
}
