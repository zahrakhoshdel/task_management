// ignore_for_file: must_be_immutable

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/constants/text_styles.dart';

class ScreenTitle extends StatelessWidget {
  Size size;
  String title;
  ScreenTitle({Key? key, required this.size, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.headingTextStyle,
        ),
        Container(
          width: size.width * 0.1,
          height: size.width * 0.01,
          color: AppColors.primaryColor,
        )
      ],
    );
  }
}
