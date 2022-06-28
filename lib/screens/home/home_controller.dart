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
}
