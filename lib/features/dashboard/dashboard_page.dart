import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const Center(
        child: Text('You are now logged in!'),
      ),
    );
  }
}
