import 'package:get/get.dart';
import 'package:sanchoy/ui/controller/Login_controller.dart';


class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  
  }
}
