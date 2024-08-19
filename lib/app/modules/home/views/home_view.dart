import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:smart_light/app/modules/home/widgets/light_basement.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenHeight = size.height;
    final screenWidth = size.width;
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // leading: const Icon(
        //   Icons.menu,
        // ),
      ),
      backgroundColor: Colors.white,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
        color: Colors.black,
        child: SafeArea(
          top: false,
          child: Obx(
            () {
              return SizedBox(
                width: screenWidth,
                height: screenHeight,
                // padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.loose,
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: -45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    height: screenHeight / 10,
                                    width: screenHeight / 10,
                                    decoration: BoxDecoration(
                                      color:
                                          controller.lightIntensity.value == 0
                                              ? Colors.grey.withOpacity(.4)
                                              : Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: controller
                                                      .lightIntensity.value ==
                                                  0
                                              ? Colors.transparent
                                              : controller.lightIntensity
                                                          .value >
                                                      79
                                                  ? Colors.white
                                                      .withOpacity(0.95)
                                                  : Colors.white
                                                      .withOpacity(0.85),
                                          spreadRadius: 8 *
                                              controller.lightIntensity.value,
                                          blurRadius: 100,
                                          offset: Offset(
                                              0,
                                              2.5 *
                                                  controller
                                                      .lightIntensity.value),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                                .animate()
                                .fadeIn(delay: const Duration(seconds: 1)),
                            const LightBasement(),
                          ],
                        ),
                        const Spacer(),
                        if (!controller.isTurnOff.value)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  "Intensity",
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: Colors.orange.shade900,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Slider.adaptive(
                                    activeColor: Colors.orange.shade900,
                                    value: controller.lightIntensity.value,
                                    label: controller.lightIntensity.value
                                        .toString(),
                                    divisions: 5,
                                    min: 0,
                                    max: 100,
                                    onChanged: (value) {
                                      controller.lightIntensity.value = value;
                                      if (value == 0.0) {
                                        controller.isTurnOff(true);
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ...List.generate(
                                        120 ~/ 20,
                                        (index) {
                                          return Text(
                                            '${index * 20}%',
                                            style: TextStyle(
                                                color: controller.lightIntensity
                                                            .value >
                                                        40
                                                    ? Colors.black
                                                    : Colors.white,
                                                fontSize: controller
                                                            .lightIntensity
                                                            .value
                                                            .toInt() ==
                                                        (index * 20)
                                                    ? 15
                                                    : 10),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                              .animate()
                              .slideY(
                                  begin: 1,
                                  end: 0,
                                  duration: const Duration(milliseconds: 400))
                              .fadeIn(),
                      ],
                    ),
                    Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          right: screenWidth * .07,
                          height: controller.panduleHeight.value,
                          child: GestureDetector(
                            onVerticalDragUpdate: (details) {
                              controller.getHeight(
                                screenHeight * .5,
                                details.delta.dy * 2,
                              );
                            },
                            onVerticalDragEnd: (details) {
                              controller.resetHeight();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      // border: Border.all(),
                                    ),
                                    width: 40,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: 2,
                                            decoration: const BoxDecoration(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: theme.primaryColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      right: 10,
                      height: screenHeight * .5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RotatedBox(
                            quarterTurns: 3,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.keyboard_double_arrow_left_rounded,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 1),
                                Text(
                                  "Pull Me",
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
