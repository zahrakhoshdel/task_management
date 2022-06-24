// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/constants/text_styles.dart';
import 'package:task_management/routes/app_pages.dart';
import 'package:task_management/screens/authentication/authentication_controller.dart';
import 'package:task_management/screens/authentication/widgets/build_signup_form.dart';
import 'package:task_management/widgets/custom_button.dart';
import 'package:task_management/screens/authentication/widgets/text_with_text_button.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: size.height * 0.1,
        title: Text(
          'Sign Up',
          style:
              TextStyles.headingTextStyle.copyWith(color: AppColors.greyColor),
        ),
        leading: Container(),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 199, 203, 205),
              Color.fromARGB(255, 236, 245, 252),
              Color.fromARGB(255, 209, 207, 214)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1, vertical: size.height * 0.1),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  BuildSignUpForm(
                    userNameController: userNameController,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CustomButton(
                      text: 'Sign Up',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String username = userNameController.text.trim();
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();
                          var date = controller.selectedDate.value;

                          controller.createAccount(
                              username, email, password, date);
                        }
                      }),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TextWithTextButton(
                    text: 'Already have an account?',
                    textButton: 'Sign In',
                    onPressed: () => Get.toNamed(Routes.LOGIN),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
