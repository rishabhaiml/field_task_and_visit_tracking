import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/activity_controller.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  // Simple helper to format the datetime
  String _formatTime(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    return '${time.day}/${time.month}/${time.year}';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActivityController());

    return Scaffold(
      body: Obx(() {
        if (controller.activities.isEmpty) {
          return const Center(
            child: Text(
              'No recent activity.',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.loadActivities(),
          child: ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: controller.activities.length,
            itemBuilder: (context, index) {
              final log = controller.activities[index];

              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header: Icon, Title, and Timestamp
                      Row(
                        children: [
                          Icon(log.icon, color: log.iconColor, size: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              log.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            _formatTime(log.timestamp),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Body: The description / notes
                      Text(
                        log.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),

                      // Conditionally render the Mock AI Output if it exists
                      if (log.aiInsight != null) ...[
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: log.aiInsight!.contains('⚠️')
                                ? Colors.red.shade50
                                : Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: log.aiInsight!.contains('⚠️')
                                  ? Colors.red.shade200
                                  : Colors.blue.shade200,
                            ),
                          ),
                          child: Text(
                            log.aiInsight!,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: log.aiInsight!.contains('⚠️')
                                  ? Colors.red.shade900
                                  : Colors.blue.shade900,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
