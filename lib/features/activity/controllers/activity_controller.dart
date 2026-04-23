import 'package:get/get.dart';
import '../../../data/services/mock_data_service.dart';

class ActivityController extends GetxController {
  final MockDataService _dataService = Get.find<MockDataService>();

  // Observable list of formatted log strings (in a real app, this would be an ActivityLogModel)
  final activities = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadActivities();
  }

  void loadActivities() {
    List<String> logs = [];

    // Generate logs from Tasks
    for (var task in _dataService.tasks) {
      logs.add('Task Assigned: "${task.title}" (Status: ${task.status.name})');
    }

    // Generate logs from Visits
    for (var visit in _dataService.visits) {
      logs.add('Visit Logged: For Task ${visit.taskId}. AI Output generated.');
    }

    // Reverse the list so the newest items appear at the top
    activities.value = logs.reversed.toList();
  }
}
