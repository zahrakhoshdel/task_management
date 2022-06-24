// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/constants/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RawMaterialButton(
      //fillColor: kBlueColor,
      fillColor: AppColors.primaryColor.withOpacity(0.5),
      splashColor: Colors.blueAccent,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1, vertical: size.height * 0.015),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              text,
              maxLines: 1,
              style: TextStyles.titleTextStyle
                  .copyWith(color: AppColors.snackbarTextColor),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}
