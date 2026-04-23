import 'package:field_task_and_visit_tracking/data/models/activity_log_model.dart';
import 'package:field_task_and_visit_tracking/data/models/task_model.dart'
    show TaskStatus, TaskModel;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/mock_data_service.dart';

import '../../../data/models/user_model.dart';

class ActivityController extends GetxController {
  final MockDataService _dataService = Get.find<MockDataService>();

  final activities = <ActivityLogModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadActivities();
  }

  void loadActivities() {
    List<ActivityLogModel> logs = [];

    // 1. Process Task Events
    for (var task in _dataService.tasks) {
      logs.add(
        ActivityLogModel(
          title:
              'Task ${task.status == TaskStatus.pending ? 'Assigned' : 'Updated'}',
          description:
              'Task "${task.title}" is currently ${task.status.name.toUpperCase()}.',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          icon: Icons.assignment_turned_in,
          iconColor: Colors.blue,
        ),
      );
    }

    // 2. Process Visit Events
    for (var visit in _dataService.visits) {
      // Find the Agent Name
      final agentName = _dataService.users
          .firstWhere(
            (u) => u.id == visit.agentId,
            orElse: () => UserModel(
              id: '',
              name: 'Unknown Agent',
              role: UserRole.fieldAgent,
            ),
          )
          .name;

      // Find the Task Title so we know WHICH visit this is!
      final taskTitle = _dataService.tasks
          .firstWhere(
            (t) => t.id == visit.taskId,
            orElse: () => TaskModel(
              id: '',
              title: 'Unknown Task',
              description: '',
              assignedToId: '',
              status: TaskStatus.pending,
              dueDate: DateTime.now(),
            ),
          )
          .title;

      // Dynamically change the text based on status
      String actionText = 'Logged';
      if (visit.status == 'Pending') actionText = 'Logged (Pending)';
      if (visit.status == 'In Progress') actionText = 'Started';
      if (visit.status == 'Completed') actionText = 'Completed';

      logs.add(
        ActivityLogModel(
          title: '📍 Visit $actionText by $agentName',
          description:
              'For Task: "$taskTitle"\nAgent Notes: "${visit.notes}"', // <-- Added Task Title!
          timestamp: DateTime.now(),
          icon: visit.status == 'Completed'
              ? Icons.check_circle
              : Icons.location_on, // Dynamic icon!
          iconColor: visit.status == 'Completed' ? Colors.green : Colors.orange,
          aiInsight: visit.mockAiInsight,
        ),
      );
    }

    logs.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    activities.value = logs;
  }
}
