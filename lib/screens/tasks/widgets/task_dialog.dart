// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/constants/text_styles.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/screens/tasks/task_controller.dart';
import 'package:task_management/widgets/custom_button.dart';

class TaskDialog extends StatefulWidget {
  final TaskModel? task;
  final String? id;
  final String? payload;

  const TaskDialog({
    Key? key,
    this.task,
    this.id,
    this.payload,
  });

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final taskController = Get.put(TaskController());

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _title;
  late TextEditingController _description;
  late DateTime _taskDate;
  late TimeOfDay _time;
  late bool _isDone;
  late bool _notification;
  late bool processing;

  String buttonText = "Save";
  bool addNewTask = true;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _description = TextEditingController();
    _taskDate = DateTime.now();
    _time = TimeOfDay.now();
    _isDone = false;
    _notification = false;
    if (widget.task != null) {
      populateForm();
    }
    processing = false;
  }

  void populateForm() {
    _title.text = widget.task!.title!;
    _description.text = widget.task!.description!;
    _taskDate = DateTime.tryParse(widget.task!.taskDate!)!;
    _time = TimeOfDay(
        hour: int.parse(widget.task!.time!.split(":")[0]),
        minute: int.parse(widget.task!.time!.split(":")[1]));
    _isDone = widget.task!.done;
    _notification = widget.task!.notification;

    buttonText = "Update";
    addNewTask = false;
    setState(() {});
  }

  void deleteTask() async {
    try {
      await taskController.deleteTask(widget.id!);
      Get.back();
      setState(() {
        processing = false;
      });
    } catch (e) {
      print("Error $e");
    }
  }

  void saveTask() async {
    try {
      if (addNewTask) {
        await taskController.addTask(
          title: _title.text,
          description: _description.text,
          taskDate: _taskDate,
          time: _time,
          done: _isDone,
        );
      } else {
        taskController.editTask(
          id: widget.id!,
          title: _title.text,
          description: _description.text,
          taskDate: _taskDate,
          time: _time,
          done: _isDone,
          notification: _notification,
        );
      }

      setState(() {
        processing = false;
      });
      Get.back();
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.65,
      height: size.height * 0.5,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.03),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextFormField(
                  controller: _title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: _description,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                ListTile(
                  title: const Text("Select Date of Task"),
                  subtitle: Text(
                      "${_taskDate.year} - ${_taskDate.month} - ${_taskDate.day}"),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: _taskDate,
                        firstDate: DateTime(_taskDate.year - 5),
                        lastDate: DateTime(_taskDate.year + 5));
                    if (picked != null) {
                      setState(() {
                        _taskDate = picked;
                      });
                    }
                  },
                ),
                ListTile(
                  title: const Text("Select Time of Task"),
                  subtitle: Text(_time.format(context)),
                  onTap: () async {
                    TimeOfDay? picked = await showTimePicker(
                        context: context, initialTime: _time);

                    if (picked != null) {
                      setState(() {
                        _time = picked;
                      });
                    }
                  },
                ),
                ListTile(
                  title: const Text('Completed'),
                  trailing: Checkbox(
                    value: _isDone,
                    onChanged: (value) {
                      setState(() {
                        _isDone = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Before creating a task, please check the enter information again',
                    style: TextStyles.subtitleTextStyle
                        .copyWith(color: AppColors.greyColor),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                processing
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            CustomButton(
                                text: buttonText,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      processing = true;
                                    });
                                    saveTask();
                                  }
                                }),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
