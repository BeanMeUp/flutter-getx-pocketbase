import 'package:get/get.dart';
import 'core/middleware/route_guard.dart';
import 'features/dashboard/dashboard_bindings.dart';
import 'features/dashboard/dashboard_page.dart';
import 'features/home/home_bindings.dart';
import 'features/home/home_page.dart';

List<GetPage<dynamic>> get routes {
  return [
    GetPage(
      name: '/',
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => const DashboardPage(),
      binding: DashboardBindings(),
      middlewares: [RouteGuard()],
    ),
  ];
}
