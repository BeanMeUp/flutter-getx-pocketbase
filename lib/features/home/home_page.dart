import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/controllers/auth_controller.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async =>
                    {await authController.loginProvider("google")},
                child: const Text('Login to Google'))
          ],
        ),
      ),
    );
  }
}
