import 'package:field_task_and_visit_tracking/features/authentication/views/login_screen.dart';
import 'package:field_task_and_visit_tracking/features/dashboard/views/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'data/services/mock_data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inject our fake backend into GetX memory
  await Get.putAsync(() => MockDataService().init());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Field Force Assignment',
      theme: ThemeData(primarySwatch: Colors.blue),
      // We will define the initialRoute and pages next!
      home: const Scaffold(body: Center(child: Text('Setup Complete!'))),
      // Add this inside your GetMaterialApp in main.dart:
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        
        GetPage(name: '/dashboard', page: () => const DashboardScreen()),
      ],
    );
  }
}
