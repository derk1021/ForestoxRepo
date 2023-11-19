import 'package:get/get.dart';

import '../screens/auth/login/controller/login_controller.dart';
import '../screens/home/discussion/controller/discussion_controller.dart';
import '../screens/home/forecast/forecast_detail/controller/forecast_detail_controller.dart';
import '../screens/home/forecast/forecast_landing/controller/forecast_landing_controller.dart';
import '../screens/home/notifications/controller/notifications_controller.dart';
import '../screens/home/stocks/stock_detail/controller/stock_detail_controller.dart';
import '../screens/home/stocks/stocks_landing/controller/stocks_landing_controller.dart';

class InitializingDependency implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LogInController(),
      fenix: true,
    );
    Get.lazyPut(
      () => DiscussionController(),
      fenix: true,
    );
    Get.lazyPut(
      () => ForecastDetailController(),
      fenix: true,
    );
    Get.lazyPut(
      () => ForecastLandingController(),
      fenix: true,
    );
    Get.lazyPut(
      () => StockDetailController(),
      fenix: true,
    );
    Get.lazyPut(
      () => StocksLandingController(),
      fenix: true,
    );
    Get.lazyPut(
      () => NotificationsController(),
      fenix: true,
    );
  }
}
