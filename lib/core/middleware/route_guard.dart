import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import '../services/local_storage.dart';
import '../services/pocketbase/pocketbase.dart';

class RouteGuard extends GetMiddleware {
  final PocketBase pb = PocketBaseSingleton().client;
  final LocalStorage storage = LocalStorage();

  @override
  RouteSettings? redirect(String? route) {
    // User is not authenticated, redirect to login page
    if (!pb.authStore.isValid) {
      Get.offAllNamed('/login');
    }

    return null;
  }
}
