import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/screens/authentication/authentication_controller.dart';

class DatePickerWidget extends StatelessWidget {
//  final String text;
  final VoidCallback onPressed;
  DatePickerWidget({Key? key, required this.onPressed}) : super(key: key);

  final controller = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.white.withOpacity(0.5),
      splashColor: AppColors.primaryColor,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: Row(
            children: [
              const Icon(Icons.calendar_month_outlined),
              const SizedBox(
                width: 20,
              ),
              Obx(
                () => Text(
                  DateFormat("dd-MM-yyyy")
                      .format(controller.selectedDate.value)
                      .toString(),
                  maxLines: 1,
                  style: const TextStyle(fontSize: 25, color: Colors.black87),
                ),
              ),
            ],
          )),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(color: AppColors.primaryColor),
      ),
    );
  }
}
