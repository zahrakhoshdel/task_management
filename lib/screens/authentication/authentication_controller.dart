import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/constants/app_colors.dart';
import 'package:task_management/routes/app_pages.dart';
import 'package:task_management/screens/authentication/data_service.dart';
import 'package:task_management/widgets/indicator_widget.dart';

class AuthenticationController extends GetxController {
  var displayName = '';

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get userProfile => auth.currentUser;

  @override
  void onInit() {
    displayName = userProfile != null ? userProfile!.displayName! : '';
    super.onInit();
  }

  void createAccount(
      String name, String email, String password, var date) async {
    try {
      Indicator.showLoading();

      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayName = name;
        auth.currentUser!.updateDisplayName(name);
      });

      update();

      await DatabaseService(uid: userProfile!.uid)
          .updateUserData(
        email: email,
        name: name,
        birthdate: date,
      )
          .then((value) {
        Indicator.closeLoading();
        Get.toNamed(Routes.HOME);
      });
    } on FirebaseAuthException catch (e) {
      Indicator.closeLoading();
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = ('The account already exists for that email.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.snackbarTextColor);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.snackbarTextColor);
    }
  }

  void signIn(String email, String password) async {
    try {
      Indicator.showLoading();
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        displayName = userProfile!.displayName!;
        Indicator.closeLoading();
      });

      update();
      Get.toNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      Indicator.closeLoading();
      String title = e.code.replaceAll(RegExp('-'), ' ').capitalize!;

      String message = '';

      if (e.code == 'wrong-password') {
        message = 'Invalid Password. Please try again!';
      } else if (e.code == 'user-not-found') {
        message =
            ('The account does not exists for $email. Create your account by signing up.');
      } else {
        message = e.message.toString();
      }

      Get.snackbar(title, message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.snackbarTextColor);
    } catch (e) {
      Get.snackbar(
        'Error occured!',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.snackbarTextColor,
      );
    }
  }

  void signout() async {
    try {
      await auth.signOut();
      displayName = '';
      update();

      Get.toNamed(Routes.LOGIN);
    } catch (e) {
      Get.snackbar('Error occured!', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: AppColors.snackbarTextColor);
    }
  }

  /// Date Picker
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      initialEntryMode: DatePickerEntryMode.input,
      initialDatePickerMode: DatePickerMode.day,
      errorInvalidText: 'Enter valid date range',
      fieldHintText: 'Month/Day/Year',
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }
}

// to capitalize first letter of a Sting
extension StringExtension on String {
  String capitalizeString() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
