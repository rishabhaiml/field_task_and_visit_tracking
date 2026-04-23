import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/mock_data_service.dart';

class AuthController extends GetxController {
  // Inject the mock database service we created earlier
  final MockDataService _dataService = Get.find<MockDataService>();

  // Observables for state management
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  // Holds the currently logged-in user. Null means not logged in.
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  final TextEditingController nameController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      errorMessage.value = 'Please enter a name.';
      return;
    }

    // Reset error and start loading state
    errorMessage.value = '';
    isLoading.value = true;

    // Call our fake backend
    final user = await _dataService.login(name);

    isLoading.value = false;

    if (user != null) {
      // Success! Store the user and navigate to the dashboard
      currentUser.value = user;
      Get.offAllNamed(
        '/dashboard',
      ); // Route to dashboard (we will define this next)
    } else {
      // Error handling
      errorMessage.value = 'User not found. Try "Dave Agent" or "Alice Admin".';
    }
  }

  void logout() {
    currentUser.value = null;
    nameController.clear();
    Get.offAllNamed('/login');
  }
}
