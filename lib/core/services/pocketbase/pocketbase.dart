// pocketbase_singleton.dart
import 'package:pocketbase/pocketbase.dart';
import '../local_storage.dart';
import 'factories/factory_mobile.dart'
    if (dart.library.html) 'factories/factory_web.dart';

class PocketBaseSingleton {
  static final PocketBaseSingleton _instance = PocketBaseSingleton._internal();

  late final PocketBase client;

  factory PocketBaseSingleton() {
    return _instance;
  }

  PocketBaseSingleton._internal();

  Future<void> initialize() async {
    final LocalStorage storage = LocalStorage();

    final token = await storage.getToken();

    final customAuthStore = AsyncAuthStore(
      initial: token,
      save: storage.setToken,
      clear: storage.deleteToken,
    );

    client = PocketBase(
      "http://127.0.0.1:8090", // Use the environment variable
      httpClientFactory: httpClientFactory.getHttpClient(),
      authStore: customAuthStore,
    );

    if (client.authStore.isValid) {
      await client.collection('users').authRefresh();
    }
  }
}
