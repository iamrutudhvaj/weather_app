import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/weather_data_page_controller.dart';

class WeatherDataPageView extends GetView<WeatherDataPageController> {
  const WeatherDataPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherDataPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "${controller.homeController.weatherData?.name}",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
