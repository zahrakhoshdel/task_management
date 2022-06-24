import 'package:flutter/material.dart';
import 'package:task_management/constants/app_colors.dart';

abstract class TextStyles {
  static const TextStyle headingTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
    fontSize: 40,
  );

  static const TextStyle titleTextStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
    fontSize: 22,
  );

  static const TextStyle subtitleTextStyle = TextStyle(
    fontWeight: FontWeight.w700,
    color: AppColors.greyColor,
    fontSize: 16,
  );
}
