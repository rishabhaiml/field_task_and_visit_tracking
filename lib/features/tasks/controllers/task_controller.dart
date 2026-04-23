import 'package:get/get.dart';
import '../../../data/models/task_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/services/mock_data_service.dart';
import '../../authentication/controllers/auth_controller.dart';

class TaskController extends GetxController {
  final MockDataService _dataService = Get.find<MockDataService>();
  final AuthController _authController = Get.find<AuthController>();

  // State observables
  final tasks = <TaskModel>[].obs;
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;

    final currentUser = _authController.currentUser.value;
    if (currentUser == null) {
      isLoading.value = false;
      return;
    }

    // Role-based data fetching: Field Agents only see their own tasks
    if (currentUser.role == UserRole.fieldAgent) {
      tasks.value = await _dataService.getTasks(assignedToId: currentUser.id);
    } else {
      // Admins and Managers see all tasks
      tasks.value = await _dataService.getTasks();
    }

    isLoading.value = false;
  }
}
