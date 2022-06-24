// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:task_management/widgets/rounded_text_form_field.dart';

class BuildSignInForm extends StatelessWidget {
  TextEditingController emailController;
  TextEditingController passwordController;
  BuildSignInForm(
      {Key? key,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        RoundedTextFormField(
            controller: emailController,
            hintText: 'Email',
            icon: Icons.person_outline,
            obsecureText: false,
            validator: (value) {
              bool _isEmailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!);
              if (!_isEmailValid) {
                return 'Invalid email';
              }
              return null;
            }),
        SizedBox(
          height: size.height * 0.02,
        ),
        RoundedTextFormField(
            controller: passwordController,
            hintText: 'Password',
            icon: Icons.lock_outline,
            obsecureText: true,
            validator: (value) {
              if (value.toString().length < 6) {
                return 'Password should be longer or equal to 6 characters.';
              }
              return null;
            }),
      ],
    );
  }
}
