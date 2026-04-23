import 'package:field_task_and_visit_tracking/features/activity/views/activity_screen.dart';
import 'package:field_task_and_visit_tracking/features/tasks/views/task_list_screen.dart';
import 'package:field_task_and_visit_tracking/features/visits/views/visit_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../authentication/controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../../../data/models/user_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final DashboardController dashboardController = Get.put(
      DashboardController(),
    );

    // Ensure we have a user logged in, otherwise show an error/fallback
    final currentUser = authController.currentUser.value;
    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text('Session expired. Please log in.')),
      );
    }

    // Define the navigation items based on the user's role
    final List<NavigationDestination> navDestinations = _buildNavDestinations(
      currentUser.role,
    );

    // Define the screens corresponding to the tabs
    final List<Widget> screens = _buildScreens(currentUser.role);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${currentUser.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: authController.logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Obx(() => screens[dashboardController.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: dashboardController.selectedIndex.value,
          onDestinationSelected: dashboardController.changeTabIndex,
          destinations: navDestinations,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Role-Based Logic Helpers
  // ---------------------------------------------------------------------------

  List<NavigationDestination> _buildNavDestinations(UserRole role) {
    List<NavigationDestination> destinations = [
      const NavigationDestination(icon: Icon(Icons.assignment), label: 'Tasks'),
    ];

    // Field Agents get a specific "Visits" tab to log their fieldwork
    if (role == UserRole.fieldAgent) {
      destinations.add(
        const NavigationDestination(
          icon: Icon(Icons.location_on),
          label: 'Visits',
        ),
      );
    }

    // Everyone gets an Activity/History tab, but managers might see team-wide activity later
    destinations.add(
      const NavigationDestination(icon: Icon(Icons.history), label: 'Activity'),
    );

    return destinations;
  }

 List<Widget> _buildScreens(UserRole role) {
    List<Widget> screens = [const TaskListScreen()];

    if (role == UserRole.fieldAgent) {
      screens.add(const VisitFormScreen());
    }

    // Replace the placeholder with the actual ActivityScreen
    screens.add(const ActivityScreen());

    return screens;
  }
}
