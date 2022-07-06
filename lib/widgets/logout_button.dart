// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/constants/text_styles.dart';

class LogoutButton extends StatelessWidget {
  final String text;
  final icon;
  final VoidCallback onPressed;

  const LogoutButton(
      {Key? key,
      required this.text,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(
        icon,
        color: AppColors.primaryColor,
      ),
      label: Text(
        text,
        style: TextStyles.subtitleTextStyle
            .copyWith(color: AppColors.primaryColor),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: const BorderSide(width: 2.0, color: AppColors.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      ),
    );
  }
}
