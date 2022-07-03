// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/constants/text_styles.dart';
import 'package:task_management/screens/tasks/notification_api.dart';
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

  bool isnotif = false;

  @override
  void initState() {
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(OnNotificationClick);
  }

  onNotificationReceive(ReceiveNotification notification) {
    //print('notification recieved: ${notification.id}');
  }

  OnNotificationClick(String payload) {
    // print('payload $payload');
  }

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
            IconButton(
              onPressed: () async {
                int id = DateTime.now().millisecondsSinceEpoch.toInt();
                // print('${widget.data['taskDate']} ${widget.data['time']}');
                if (!widget.data['notification']) {
                  isnotif = await localNotifyManager.scheduleNotification(
                    id,
                    DateTime.tryParse(widget.data['taskDate'])!,
                    TimeOfDay(
                        hour: int.parse(widget.data['time'].split(":")[0]),
                        minute: int.parse(widget.data['time'].split(":")[1])),
                    widget.data['title'],
                    widget.data['description'],
                  );
                  Get.snackbar('Scheduled ',
                      'Scheduled for ${widget.data['title']} on ${DateTime.tryParse(widget.data['taskDate'])!}');
                }

                //print('isnotif: $isnotif');

                if (isnotif) {
                  await taskController.editTask(
                    id: widget.taskId,
                    title: widget.data['title'],
                    description: widget.data['description'],
                    taskDate: DateTime.tryParse(widget.data['taskDate'])!,
                    time: TimeOfDay(
                        hour: int.parse(widget.data['time'].split(":")[0]),
                        minute: int.parse(widget.data['time'].split(":")[1])),
                    done: widget.data['done'],
                    notification: !widget.data['notification'],
                  );
                }
                setState(() {});
              },
              icon: widget.data['notification']
                  ? const Icon(
                      Icons.notifications_active_outlined,
                      color: AppColors.primaryColor,
                    )
                  : const Icon(
                      Icons.notifications_off_outlined,
                      color: AppColors.greyColor,
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
