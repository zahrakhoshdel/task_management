// ignore_for_file: use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/constants/text_styles.dart';
import 'package:task_management/screens/tasks/task_controller.dart';
import 'package:task_management/screens/tasks/widgets/task_card.dart';
import 'package:task_management/widgets/screen_title.dart';

class TaskScreen extends StatelessWidget {
  final TaskController controller = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenTitle(size: size, title: 'All Tasks'),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              child: StreamBuilder(
                stream: controller.getTasks(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong!"),
                    );
                  }

                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Text(
                        'No Tasks',
                        style:
                            TextStyles.subtitleTextStyle.copyWith(fontSize: 30),
                      ));
                    }
                    return ListView(
                      shrinkWrap: true,
                      //  reverse: true,
                      physics: const BouncingScrollPhysics(),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map data = document.data()! as Map;
                        String taskId = document.id;
                        // print(data);
                        return TaskCard(data: data, taskId: taskId);
                      }).toList(),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
