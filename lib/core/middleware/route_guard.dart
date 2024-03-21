import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class RouteGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final AuthController authController = Get.find<AuthController>();
    // User is not authenticated, redirect to login page
    if (!authController.isUserAuthenticated.value && route != '/login') {
      return const RouteSettings(name: '/login');
    }
    // User is authenticated and has a profile, continue as is
    return null;
  }
}
