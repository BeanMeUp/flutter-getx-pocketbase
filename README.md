# flutter_getx_pocketbase

A quick example on how to do Google Authentication for iOS, Android, and Web with Pocketbase in Flutter using GetX.

## Getting Started

Copy `.env.example` to `.env` and add your PocketBase URL to it
`POCKETBASE_URI=http://127.0.0.1:8090`

## How It Works

This example uses getx to handle middleware, routing, and controllers for the authentication.
It also uses flutter_secure_storage to store the authentication token for session handling.

### main.dart

In `main.dart` you can see:

```dart
await dotenv.load(fileName: ".env"); // Load environment variables
Get.put(AuthController()); // Initialize the AuthController
```

This loads your `.env` variables and the `AuthController()`

There is also:

```dart
    return GetMaterialApp(
      title: 'Flutter GetX Pocketbase Example',
      initialRoute: '/',
      getPages: routes,
    );
```

Which is where the routing is handled

### routes.dart

In the routing you can add `RouteGuard()` into the middleware of the routes that need to be authenticated.

### core/middleware/route_guard.dart

The route guard checks to see if you have a session, if you do not you are redirected to the login page

### core/controllers/auth_controller.dart

`restoreSession()` checks to see if you have a token that is set by the `login()` or `loginProvider()`

```dart
void restoreSession() async {
    String? token = await _secureStorageService.getToken();
    if (token != null && token.isNotEmpty) {
      isUserAuthenticated.value = true;
    } else {
      isUserAuthenticated.value = false;
    }
  }
```

`loginProvider()` uses PocketBase's `authWithOAuth2()` to login with any provider you setup in your PocketBase admin. With Google specificly, since it uses deep linking, you only need to setup a web client ID. No need for multiple Client IDs for Android and iOS.

`await launchUrl(url, webOnlyWindowName: '_blank');` opens up the authentication in a new window `webOnlyWindowName: '_blank'` is needed to fix issues with web.

If the login was successful then it saves a token that is read by the session above.

```dart
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
```

## Work around for limitations

In the PocketBase dart SDK, there are some limitations to Flutter web.

https://github.com/pocketbase/dart-sdk?tab=readme-ov-file#limitations

What is not documented is that the `package:fetch_client/fetch_client.dart` package cannot be compiled to the mobile Flutter builds. So this works great for web only, but if you do web and mobile builds you will get a compile error.

To get around this I made `core/services/pocketbase/pocketbase.dart` which modifies the solution in the documentation.

Instead of just making it conditional `kIsWeb ? () => FetchClient(mode: RequestMode.cors) : null`, I made two factories for web and mobile. Depending on what you are building for, it will only import the factory for that build.

```dart
import 'factories/factory_mobile.dart'
    if (dart.library.html) 'factories/factory_web.dart';
```

Now `package:fetch_client/fetch_client.dart` will no longer give you an error if you build for mobile because that package is no longer being imported unless the build is for web.
