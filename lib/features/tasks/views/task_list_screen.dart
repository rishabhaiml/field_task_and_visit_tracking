import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/task_controller.dart';
import '../../../core/constants/theme.dart'; // Assume you have basic colors here

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the controller when the screen is built
    final TaskController controller = Get.put(TaskController());

    return Scaffold(
      body: Obx(() {
        // 1. Handle Loading State
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // 2. Handle Empty State
        if (controller.tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                const Text(
                  'No tasks assigned yet.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        // 3. Handle Success State
        return RefreshIndicator(
          onRefresh: controller.fetchTasks,
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.tasks.length,
            itemBuilder: (context, index) {
              final task = controller.tasks[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12.0),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Status: ${task.status.name.toUpperCase()}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // We will route to the Task Details screen later
                    Get.snackbar(
                      'Task Tapped',
                      'Navigate to details for ${task.title}',
                    );
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
