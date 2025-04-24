import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/visit_controller.dart';
import '../controllers/doctor_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => VisitController());
    Get.lazyPut(() => DoctorController());
  }
}