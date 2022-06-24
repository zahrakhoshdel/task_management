// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/screens/authentication/authentication_controller.dart';
import 'package:task_management/widgets/date_picker_widget.dart';
import 'package:task_management/widgets/rounded_text_form_field.dart';

class BuildSignUpForm extends StatefulWidget {
  TextEditingController userNameController;
  TextEditingController emailController;
  TextEditingController passwordController;
  BuildSignUpForm(
      {Key? key,
      required this.userNameController,
      required this.emailController,
      required this.passwordController})
      : super(key: key);

  @override
  State<BuildSignUpForm> createState() => _BuildSignUpFormState();
}

class _BuildSignUpFormState extends State<BuildSignUpForm> {
  final controller = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        RoundedTextFormField(
            controller: widget.userNameController,
            hintText: 'Username',
            icon: Icons.person_outline,
            obsecureText: false,
            validator: (value) {
              if (value.toString().length < 3) {
                return 'Username should be longer or equal to 3 characters.';
              }
              return null;
            }),
        SizedBox(
          height: size.height * 0.02,
        ),
        RoundedTextFormField(
            controller: widget.emailController,
            hintText: 'Email',
            icon: Icons.email_outlined,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: const Text(
                'BirthDate:',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: DatePickerWidget(
                onPressed: () => controller.chooseDate(),
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        RoundedTextFormField(
            controller: widget.passwordController,
            hintText: 'Password',
            icon: Icons.lock_outline,
            obsecureText: true,
            validator: (value) {
              if (value.toString().length < 6) {
                return 'Password should be longer or equal to 6 characters.';
              }
              return null;
            }),
        SizedBox(
          height: size.height * 0.02,
        ),
        RoundedTextFormField(
            hintText: 'Confirm password',
            icon: Icons.lock_outline,
            obsecureText: true,
            validator: (value) {
              if (value.trim() != widget.passwordController.text.trim()) {
                return 'Passwords does not match';
              }
              return null;
            }),
      ],
    );
  }
}
