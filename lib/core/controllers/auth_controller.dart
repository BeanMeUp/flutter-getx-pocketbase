import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/pocketbase/pocketbase.dart';

class AuthController extends GetxController {
  final PocketBase pb = PocketBaseSingleton().client;

  Future<void> login(String email, String password) async {
    final user = await pb.collection('users').authWithPassword(email, password);
    if (user.token.isNotEmpty && user.record != null) {
      Get.offAllNamed('/dashboard');
    }
  }

  Future<void> loginProvider(String providerName) async {
    final user =
        await pb.collection('users').authWithOAuth2(providerName, (url) async {
      await launchUrl(url, webOnlyWindowName: "_blank");
    });
    if (user.token.isNotEmpty && user.record != null) {
      Get.offAllNamed('/dashboard');
    }
  }

  Future<void> logout() async {
    await _clearUserInfo();
    Get.offAllNamed('/login');
  }

  Future<void> _clearUserInfo() async {
    pb.authStore.clear();
  }
}
