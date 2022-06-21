import 'package:get/get.dart';
import 'package:task_management/screens/authentication/authentication_controller.dart';

class AuthenticationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthenticationController>(AuthenticationController());
  }
}
