import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxString selectedCategory = 'Cardiovascular'.obs;
  final RxBool isChangingCategory = false.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }

  Future<void> changeCategory(String category) async {
    isChangingCategory.value = true;
    selectedCategory.value = category;
    await Future.delayed(const Duration(milliseconds: 500));
    isChangingCategory.value = false;
  }
}
