import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/weather_data_page/bindings/weather_data_page_binding.dart';
import '../modules/weather_data_page/views/weather_data_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WEATHER_DATA_PAGE,
      page: () => const WeatherDataPageView(),
      binding: WeatherDataPageBinding(),
    ),
  ];
}
