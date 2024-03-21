import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/pocketbase/pocketbase.dart';
import '../services/secure_storage.dart';

class AuthController extends GetxController {
  final SecureStorageService _secureStorageService = SecureStorageService();
  RxBool isUserAuthenticated = false.obs;

  void restoreSession() async {
    String? token = await _secureStorageService.getToken();
    if (token != null && token.isNotEmpty) {
      isUserAuthenticated.value = true;
    } else {
      isUserAuthenticated.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final user =
          await pb.collection('users').authWithPassword(email, password);
      await _secureStorageService.saveToken(user.token);
      isUserAuthenticated.value = true;
    } catch (e) {
      isUserAuthenticated.value = false;
    }
  }

  Future<void> loginProvider(String providerName) async {
    try {
      final authData = await pb.collection('users').authWithOAuth2(providerName,
          (url) async {
        await launchUrl(url, webOnlyWindowName: '_blank');
      });

      await _secureStorageService.saveToken(authData.token);

      isUserAuthenticated.value = true;
      Get.offAllNamed('/dashboard');
    } catch (e) {
      isUserAuthenticated.value = false;
      print(e);
    }
  }

  Future<void> logout() async {
    await _secureStorageService.deleteToken();
    isUserAuthenticated.value = false;
    pb.authStore.clear();
  }
}
