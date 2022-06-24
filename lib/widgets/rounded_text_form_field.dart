// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:task_management/constants/app_colors.dart';

class RoundedTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData icon;
  final bool obsecureText;
  final validator;

  const RoundedTextFormField({
    Key? key,
    this.controller,
    required this.hintText,
    required this.icon,
    required this.obsecureText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obsecureText,
      enableSuggestions: !obsecureText,
      autocorrect: !obsecureText,
      cursorColor: AppColors.textColor,
      style: TextStyle(color: AppColors.textColor.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: AppColors.textColor.withOpacity(0.8),
        ),
        hintText: hintText,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.errorColor),
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
      ),
      validator: validator,
      keyboardType: obsecureText
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}
