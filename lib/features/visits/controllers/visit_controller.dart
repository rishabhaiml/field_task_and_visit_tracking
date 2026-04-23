import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/visit_model.dart';
import '../../../data/services/mock_data_service.dart';
import '../../authentication/controllers/auth_controller.dart';

class VisitController extends GetxController {
  final MockDataService _dataService = Get.find<MockDataService>();
  final AuthController _authController = Get.find<AuthController>();

  // Form Controllers
  final notesController = TextEditingController();

  // State
  final isSubmitting = false.obs;
  final visitStatus = 'Pending'.obs; // Could be Pending, In Progress, Completed

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

  void updateStatus(String status) {
    visitStatus.value = status;
  }

  Future<void> submitVisit(String taskId) async {
    final notes = notesController.text.trim();
    final currentUser = _authController.currentUser.value;

    if (notes.isEmpty) {
      Get.snackbar(
        'Error',
        'Visit notes cannot be empty.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (currentUser == null) return;

    isSubmitting.value = true;

    // ⏳ Simulate network delay for submission
    await Future.delayed(const Duration(seconds: 1));

    // Create a new visit record
    final newVisit = VisitModel(
      id: 'v_${DateTime.now().millisecondsSinceEpoch}',
      taskId: taskId,
      agentId: currentUser.id,
      notes: notes,
      // We will populate mockAiInsight in the next step!
    );

    // Save to our mock database
    _dataService.visits.add(newVisit);

    isSubmitting.value = false;

    // Clear the form and show success
    notesController.clear();
    visitStatus.value = 'Completed';

    Get.snackbar(
      'Success',
      'Visit logged successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
