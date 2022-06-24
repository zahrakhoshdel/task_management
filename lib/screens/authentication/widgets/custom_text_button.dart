// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  CustomTextButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        child: Text(text),
        style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent)),
      ),
    );
  }
}
