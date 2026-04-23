import 'package:field_task_and_visit_tracking/data/models/task_model.dart';
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

    // 1. Generate AI Insight
    final aiInsight = await _aiService.analyzeNotes(notes);

    // 2. Create visit with the ACTUAL selected status
    final newVisit = VisitModel(
      id: 'v_${DateTime.now().millisecondsSinceEpoch}',
      taskId: taskId,
      agentId: currentUser.id,
      status: visitStatus.value, // <-- Save the dropdown value!
      notes: notes,
      mockAiInsight: aiInsight,
    );
    _dataService.visits.add(newVisit);

    // 3. BONUS: Sync the Task Status so the Task List screen updates!
    final taskIndex = _dataService.tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1) {
      if (visitStatus.value == 'In Progress')
        _dataService.tasks[taskIndex].status = TaskStatus.inProgress;
      if (visitStatus.value == 'Completed')
        _dataService.tasks[taskIndex].status = TaskStatus.completed;
      // Note: We leave it if pending.
    }

    isSubmitting.value = false;
    notesController.clear();

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
