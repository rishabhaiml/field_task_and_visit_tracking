import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Keeps track of the currently selected tab
  final selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
