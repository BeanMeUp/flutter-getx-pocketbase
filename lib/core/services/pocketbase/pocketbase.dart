import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pocketbase/pocketbase.dart';

// Conditional import chooses the right implementation based on the target platform.
import 'factories/factory_mobile.dart'
    if (dart.library.html) 'factories/factory_web.dart';

// Initialize PocketBase with the platform-appropriate HTTP client factory.
final PocketBase pb = PocketBase(
  dotenv.env['POCKETBASE_URI']!, // Use the environment variable
  httpClientFactory: httpClientFactory.getHttpClient(),
);
