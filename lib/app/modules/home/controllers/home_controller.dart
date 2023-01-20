import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/data/keys.dart';
import 'package:weather_app/app/data/urls.dart';
import 'package:weather_app/app/routes/app_pages.dart';

import '../../../data/models/weather_data_model.dart';

enum States { initial, loading, success, error }

class HomeController extends GetxController {
  final _weatherData = Rx<Weather?>(null);
  Weather? get weatherData => _weatherData.value;
  set weatherData(Weather? value) => _weatherData.value = value;

  final _weatherState = States.initial.obs;
  States get weatherState => _weatherState.value;
  set weatherState(States value) => _weatherState.value = value;

  TextEditingController cityNameController = TextEditingController();

  final dio = Dio();

  @override
  void onInit() {
    setUpDio();
    super.onInit();
  }

  void setUpDio() {
    try {
      dio.interceptors.add(LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getWeatherDataByCity({required String city}) async {
    try {
      weatherState = States.loading;
      final response = await dio.get(
        URLs.baseURL,
        queryParameters: {
          "q": city,
          "units": "metric",
          "appid": Keys.appId,
        },
      );
      weatherData = Weather.fromJson(response.data);
      cityNameController.clear();
      weatherState = States.success;
      Get.toNamed(Routes.WEATHER_DATA_PAGE);
    } catch (e) {
      cityNameController.clear();
      var err = e as DioError;
      Get.rawSnackbar(title: "Error", message: err.response?.data["message"]);
      weatherState = States.error;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeatherDataByLatLong() async {
    try {
      weatherState = States.loading;
      final position = await _determinePosition();
      final response = await dio.get(
        URLs.baseURL,
        queryParameters: {
          "lat": position.latitude,
          "lon": position.longitude,
          "units": "metric",
          "appid": Keys.appId,
        },
      );
      weatherData = Weather.fromJson(response.data);
      cityNameController.clear();
      weatherState = States.success;
      Get.toNamed(Routes.WEATHER_DATA_PAGE);
    } on DioError catch (err) {
      cityNameController.clear();
      Get.rawSnackbar(title: "Error", message: err.response?.data["message"]);
      weatherState = States.error;
    } on MissingPluginException catch (e) {
      Get.rawSnackbar(title: "Error", message: e.message);
      weatherState = States.error;
    } catch (e) {
      cityNameController.clear();
      Get.rawSnackbar(title: "Error", message: e.toString());
      weatherState = States.error;
    }
  }
}
