import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller.cityNameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter City..."),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: controller.getWeatherDataByLatLong,
              // () {
              //   if (controller.cityNameController.text.isNotEmpty) {

              //     // controller.getWeatherDataByCity(
              //     //     city: controller.cityNameController.text);
              //   }
              // },
              label: const Text("Search"),
              icon: Obx(() {
                if (controller.weatherState == States.loading) {
                  return const SizedBox(
                      height: 10,
                      width: 10,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                } else {
                  return const Icon(Icons.search);
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
