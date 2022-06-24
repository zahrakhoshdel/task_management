import 'package:flutter/material.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/constants/text_styles.dart';

class TextWithTextButton extends StatelessWidget {
  final String text;
  final String textButton;
  final VoidCallback onPressed;
  const TextWithTextButton(
      {Key? key,
      required this.text,
      required this.textButton,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyles.subtitleTextStyle,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(textButton,
              style: TextStyles.titleTextStyle
                  .copyWith(color: AppColors.primaryColor)),
          style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent)),
        )
      ],
    );
  }
}
