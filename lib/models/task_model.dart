import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  String? title;
  String? description;
  String? taskDate;
  String? time;
  bool done;
  bool notification;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.taskDate,
    this.time,
    this.done = false,
    this.notification = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "taskDate": taskDate,
      "time": time,
      "done": done,
      "notification": notification
    };
  }

  TaskModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        title = doc.data()!['title'],
        description = doc.data()!['description'],
        taskDate = doc.data()!['taskDate'],
        time = doc.data()!['time'],
        done = doc.data()!['done'],
        notification = doc.data()!['notification'];
}
