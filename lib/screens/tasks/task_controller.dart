import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:task_management/models/task_model.dart';

class TaskController extends GetxController {
  final String title = "task Page Title";

  FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference tasksCollection =
      FirebaseFirestore.instance.collection('Tasks');
  //final controller = Get.put(AuthenticationController());

  Future<void> addTask(
      {required String title,
      required String description,
      required DateTime taskDate,
      required TimeOfDay time,
      bool done = false}) async {
    TaskModel taskDTO = TaskModel();
    taskDTO.title = title;
    taskDTO.description = description;
    taskDTO.taskDate = taskDate.toString();
    taskDTO.time = (time.hour.toString() + ':' + time.minute.toString());
    taskDTO.done = false;
    return await tasksCollection
        .doc(auth.currentUser!.uid)
        .collection('userTasks')
        .add(
          taskDTO.toMap(),
        )
        .then((value) {
      getTasks();
    });
  }

  Future<void> editTask({
    required String id,
    required String title,
    required String description,
    required DateTime taskDate,
    required TimeOfDay time,
    required bool done,
    required bool notification,
  }) async {
    TaskModel taskDTO = TaskModel();
    taskDTO.title = title;
    taskDTO.description = description;
    taskDTO.taskDate = taskDate.toString();
    taskDTO.time = (time.hour.toString() + ':' + time.minute.toString());
    taskDTO.done = done;
    taskDTO.notification = notification;
    await tasksCollection
        .doc(auth.currentUser!.uid)
        .collection('userTasks')
        .doc(id)
        .set(
          taskDTO.toMap(),
        )
        .then((value) => getTasks());
  }

  Stream<QuerySnapshot> getTasks() {
    return tasksCollection
        .doc(auth.currentUser?.uid)
        .collection('userTasks')
        .orderBy('taskDate', descending: false)
        .snapshots();
  }

  Future<void> deleteTask(String id) async {
    await tasksCollection
        .doc(auth.currentUser!.uid)
        .collection('userTasks')
        .doc(id)
        .delete();
  }
}
