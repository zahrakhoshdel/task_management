import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/routes/app_pages.dart';
import 'package:task_management/screens/authentication/authentication_controller.dart';
import 'package:task_management/screens/authentication/widgets/build_signin_form.dart';
import 'package:task_management/screens/authentication/widgets/text_with_text_button.dart';
import 'package:task_management/widgets/Logo_widget.dart';
import 'package:task_management/widgets/custom_button.dart';

class SignInScreen extends GetWidget<AuthenticationController> {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                horizontal: size.width * 0.1, vertical: size.height * 0.2),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  LogoWidget(),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  BuildSignInForm(
                      emailController: emailController,
                      passwordController: passwordController),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CustomButton(
                      text: 'Sign In',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String email = emailController.text;
                          String password = passwordController.text;

                          controller.signIn(email, password);
                        }
                      }),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  TextWithTextButton(
                    text: 'Don\'t have an account?',
                    textButton: 'Sign Up',
                    onPressed: () => Get.toNamed(Routes.SIGN_UP),
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
