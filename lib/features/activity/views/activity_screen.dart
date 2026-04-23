import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/activity_controller.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject the controller
    final controller = Get.put(ActivityController());

    return Scaffold(
      body: Obx(() {
        if (controller.activities.isEmpty) {
          return const Center(
            child: Text(
              'No recent activity.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.loadActivities(),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8.0,
            ),
            itemCount: controller.activities.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                color: Colors.grey.shade50,
                margin: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        controller.activities[index].contains('Visit')
                            ? Icons.location_on
                            : Icons.assignment_turned_in,
                        color: controller.activities[index].contains('Visit')
                            ? Colors.green
                            : Colors.blue,
                      ),
                    ],
                  ),
                  title: Text(
                    controller.activities[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: const Text(
                    'Just now',
                    style: TextStyle(fontSize: 12),
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
