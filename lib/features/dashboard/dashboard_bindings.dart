import 'package:get/get.dart';
import './dashboard_controller.dart';

class DashboardBindings implements Bindings {
    @override
    void dependencies() {
        Get.put(DashboardController());
    }
}