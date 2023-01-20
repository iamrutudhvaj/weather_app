import 'package:get/get.dart';

import '../controllers/weather_data_page_controller.dart';

class WeatherDataPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeatherDataPageController>(
      () => WeatherDataPageController(),
    );
  }
}
