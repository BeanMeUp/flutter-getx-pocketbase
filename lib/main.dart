import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'core/controllers/auth_controller.dart';
import 'core/services/pocketbase/pocketbase.dart';
import 'routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PocketBaseSingleton().initialize();
  Get.put(AuthController()); // Initialize the AuthController
  final PocketBase pb = PocketBaseSingleton().client;
  final initialRoute = pb.authStore.isValid ? '/dashboard' : '/login';
  runApp(MyApp(initialRoute: initialRoute)); // Pass initial route to MyApp
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX Pocketbase Example',
      initialRoute: initialRoute, // Use the determined initial route
      getPages: routes,
    );
  }
}
