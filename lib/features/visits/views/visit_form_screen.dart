import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/visit_controller.dart';

class VisitFormScreen extends StatelessWidget {
  // In a real flow, you'd pass the specific Task ID this visit belongs to
  final String taskId;

  const VisitFormScreen({super.key, this.taskId = 't1'});

  @override
  Widget build(BuildContext context) {
    final VisitController controller = Get.put(VisitController());

    return Scaffold(
      appBar: AppBar(title: const Text('Log Visit')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Update Visit Status',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Reactive Dropdown for Status
            Obx(
              () => DropdownButtonFormField<String>(
                value: controller.visitStatus.value,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: ['Pending', 'In Progress', 'Completed']
                    .map(
                      (status) =>
                          DropdownMenuItem(value: status, child: Text(status)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) controller.updateStatus(value);
                },
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Visit Notes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Notes Text Field
            TextField(
              controller: controller.notesController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText:
                    'Enter details about the visit, client feedback, or issues...',
                border: OutlineInputBorder(),
              ),
            ),

            const Spacer(),

            // Reactive Submit Button
            Obx(
              () => ElevatedButton(
                onPressed: controller.isSubmitting.value
                    ? null
                    : () => controller.submitVisit(taskId),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: controller.isSubmitting.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Submit Visit Log',
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
