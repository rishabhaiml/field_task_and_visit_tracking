import 'package:get/get.dart';
import '../models/user_model.dart';
import '../models/task_model.dart';
import '../models/visit_model.dart';
import '../providers/mock_data.dart';

class MockDataService extends GetxService {
  // Observables to hold our mock database tables
  final users = <UserModel>[].obs;
  final tasks = <TaskModel>[].obs;
  final visits = <VisitModel>[].obs;

  // Initialize the service and load the seed data
  Future<MockDataService> init() async {
    // ⏳ Simulated network delay for startup
    await Future.delayed(const Duration(seconds: 1));

    // Parse the JSON lists from our mock_data.dart file into Dart models
    users.value = MockData.usersJson.map((e) => UserModel.fromJson(e)).toList();
    tasks.value = MockData.tasksJson.map((e) => TaskModel.fromJson(e)).toList();
    visits.value = MockData.visitsJson
        .map((e) => VisitModel.fromJson(e))
        .toList();

    return this;
  }

  // ----------------------------------------------------------------
  // Mock API Endpoints
  // ----------------------------------------------------------------

  /// Simulates a login request.
  /// Returns a UserModel if the name matches a dummy user, otherwise null.
  Future<UserModel?> login(String name) async {
    // ⏳ Simulated network delay so we can show a loading spinner on the UI
    await Future.delayed(const Duration(seconds: 1));

    try {
      // Simple lookup for demo purposes
      return users.firstWhere(
        (u) => u.name.toLowerCase() == name.trim().toLowerCase(),
      );
    } catch (e) {
      return null; // User not found
    }
  }

  /// Fetches tasks. If a userId is provided, it filters tasks for that specific Field Agent.
  Future<List<TaskModel>> getTasks({String? assignedToId}) async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (assignedToId != null) {
      return tasks.where((t) => t.assignedToId == assignedToId).toList();
    }
    return tasks.toList();
  }
}
