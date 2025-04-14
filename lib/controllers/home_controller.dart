import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedCategory = 'Cardiovascular'.obs;
  final doctorId = 'DOC123';
  final isChangingCategory = false.obs;
  
  Future<void> changeCategory(String newCategory) async {
    isChangingCategory.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    selectedCategory.value = newCategory;
    await Future.delayed(const Duration(milliseconds: 100));
    isChangingCategory.value = false;
  }
}
