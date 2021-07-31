import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 1.obs;
  final posts = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment(index) {
    posts.add("tes $index");
  }
}
