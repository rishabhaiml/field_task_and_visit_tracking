import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/visit_model.dart';
import '../../../data/services/mock_data_service.dart';
import '../../../data/services/mock_ai_service.dart'; // <-- Add this import
import '../../authentication/controllers/auth_controller.dart';

class VisitController extends GetxController {
  final MockDataService _dataService = Get.find<MockDataService>();
  final MockAiService _aiService =
      Get.find<MockAiService>(); // <-- Inject AI service
  final AuthController _authController = Get.find<AuthController>();

  final notesController = TextEditingController();
  final isSubmitting = false.obs;
  final visitStatus = 'Pending'.obs;

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
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (currentUser == null) return;

    isSubmitting.value = true;

    // 1. Generate the Mock AI Insight
    final aiInsight = await _aiService.analyzeNotes(notes);

    // 2. Create the visit record with BOTH notes and the AI insight
    final newVisit = VisitModel(
      id: 'v_${DateTime.now().millisecondsSinceEpoch}',
      taskId: taskId,
      agentId: currentUser.id,
      notes: notes,
      mockAiInsight: aiInsight, // <-- Store the AI output
    );

    // 3. Save to database
    _dataService.visits.add(newVisit);

    isSubmitting.value = false;

    // Clear form
    notesController.clear();
    visitStatus.value = 'Completed';

    // 4. Show the result to the reviewer immediately!
    _showAiResultDialog(aiInsight);
  }

  // Helper method to display the AI output clearly
  void _showAiResultDialog(String insight) {
    Get.defaultDialog(
      title: 'Visit Logged & Analyzed',
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          insight,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () => Get.back(),
        child: const Text('Done'),
      ),
    );
  }
}
