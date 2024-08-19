import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final lightIntensity = 0.0.obs;

  final panduleHeight = (Get.size.height * .5).obs;

  late AnimationController controller;

  late Animation<double> animation;

  final isTurnOff = true.obs;

  @override
  void onInit() async {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 500), // Adjust the duration as per your preference
    );

    animation = Tween<double>(
      begin: -0.1,
      end: 0.1,
    ).animate(controller);

    controller.repeat(reverse: true);
    await Future.delayed(
      const Duration(seconds: 3),
    );
    controller.stop();
    super.onInit();
  }

  double getHeight(double currentHeight, double additionalHeight) {
    return panduleHeight(currentHeight + additionalHeight);
  }

  void resetHeight() {
    panduleHeight(Get.size.height * .5);
    if (lightIntensity <= 0.0) {
      lightIntensity.value = 20.0;
      isTurnOff(false);
    } else if (lightIntensity > 0.0) {
      lightIntensity.value = 0.0;
      isTurnOff(true);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
