import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management/routes/app_pages.dart';
import 'package:task_management/screens/tasks/widgets/task_dialog.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void isLoggedIn() {
    if (_auth.currentUser != null) {
      Get.toNamed(Routes.HOME);
    } else {
      Get.toNamed(Routes.LOGIN);
    }
  }

  addTaskDialog(String title) async {
    Get.defaultDialog(
      title: title,
      content: const TaskDialog(),
    );
  }

  @override
  void onReady() {
    super.onReady();
    isLoggedIn();
  }

  /////////////////////////////////
  RxBool loggedIn = false.obs;
  @override
  void onInit() {
    super.onInit();
    _checkAuth();
  }

  void _checkAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        loggedIn(false);
        print('User is currently signed out');
      } else {
        loggedIn(true);
        print('User is signed in');
      }
    });
  }

  void initNaviationListener() {
    /// inital startup naviation
    _navigateBasedOnLogin();

    /// future navigation based on auth state changes
    ever(loggedIn, (value) {
      _navigateBasedOnLogin();
    });
  }

  void _navigateBasedOnLogin() {
    if (loggedIn.value == false) {
      Get.offAndToNamed(Routes.LOGIN);
    } else {
      Get.offAndToNamed(Routes.HOME);
    }
  }
}
