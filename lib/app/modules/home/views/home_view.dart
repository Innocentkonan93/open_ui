import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_color.dart';
import 'package:video_player/video_player.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    // Les dimensions en pixelsuteur
    final size = MediaQuery.of(context).size;
    final theme = context.theme;
    return Scaffold(
      // backgroundColor: const Color(0XFF0C2461),
      body: Obx(
        () {
          return SizedBox.expand(
            child: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Image.asset("assets/images/carbonfiber.png"),
                      Image.asset("assets/images/carbonfiber.png"),
                      Image.asset("assets/images/carbonfiber.png"),
                      Image.asset("assets/images/carbonfiber.png"),
                      Image.asset("assets/images/carbonfiber.png"),
                    ],
                  ),
                ),
                PageView.builder(
                  onPageChanged: (index) {
                    controller.currentIndex.value = index;
                    controller.animationController.reset();
                  },
                  physics: controller.isSelected.value
                      ? const NeverScrollableScrollPhysics()
                      : null,
                  controller: controller.pageController,
                  itemCount: controller.destinations.length,
                  itemBuilder: (context, index) {
                    final destination = controller.destinations[index];
                    return HublotView(
                      destination: destination,
                      index: index,
                    );
                  },
                ),
                AnimatedPositionedDirectional(
                  bottom:
                      controller.isViewOpen.value ? 0 : -(size.height * .25),
                  duration: const Duration(milliseconds: 500),
                  height: size.height * .25,
                  curve: Curves.bounceInOut,
                  child: Container(
                    height: size.height * .25,
                    width: size.width,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: white,
                      image: const DecorationImage(
                        image: AssetImage("assets/images/carbonfiber.png"),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              controller.destinations[
                                  controller.currentIndex.value]['name'],
                              style: theme.textTheme.headlineLarge?.copyWith(
                                color: cyan,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "${controller.destinations[controller.currentIndex.value]['price']} €",
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Obx(() {
                          return AnimatedContainer(
                            decoration: BoxDecoration(
                              color:
                                  !controller.isPlaneAnimationRunning.value &&
                                          !controller.isViewOpen.value
                                      ? Colors.transparent
                                      : cyan,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            duration: const Duration(seconds: 2),
                            height: 30,
                            width: controller.isPlaneAnimationRunning.value
                                ? size.width
                                : 10.0,
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                CupertinoIcons.airplane,
                                size: 18,
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: black,
                          ),
                          child: Text(
                            "Go",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                AnimatedPositionedDirectional(
                  top: controller.isViewOpen.value ? 0 : -(size.height * .15),
                  duration: const Duration(milliseconds: 500),
                  height: size.height * .15,
                  curve: Curves.bounceInOut,
                  child: SizedBox(
                    height: size.height * .15,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: IconButton.filledTonal(
                                onPressed: () {
                                  controller.toggleExpand();
                                },
                                icon: const Icon(
                                  Icons.close_rounded,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () {
          return Visibility(
            visible: !controller.isSelected.value,
            replacement: const SizedBox(),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black54,
              ),
              onPressed: () {
                if (controller.destinations.length ==
                    (controller.currentIndex.value + 1)) {
                  controller.pageController.previousPage(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                } else {
                  controller.pageController.nextPage(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                }
              },
              child: Visibility(
                visible: controller.destinations.length >
                    (controller.currentIndex.value + 1),
                replacement: const Icon(
                  Icons.keyboard_double_arrow_left_rounded,
                  color: cyan,
                ),
                child: const Icon(
                  Icons.keyboard_double_arrow_right_rounded,
                  color: cyan,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HublotView extends GetWidget<HomeController> {
  const HublotView({
    super.key,
    required this.destination,
    required this.index,
  });

  final Map<String, dynamic> destination;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Obx(
      () {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !controller.isSelected.value,
              replacement: const SizedBox(),
              child: const Spacer(),
            ),
            Visibility(
              visible: !controller.isSelected.value,
              replacement: const SizedBox(),
              child: Text(
                destination['name'],
                style: theme.textTheme.displayMedium?.copyWith(
                  color: Colors.cyan,
                ),
              ),
            ),
            Visibility(
              visible: !controller.isSelected.value,
              child: AnimatedBuilder(
                animation: controller.pageController,
                builder: (context, child) {
                  double opacity = 1.0;
                  double translateX = 0.0;

                  if (controller.pageController.position.haveDimensions) {
                    // Calculate opacity based on the distance from the current page
                    opacity =
                        (1 - (controller.pageController.page! - index).abs())
                            .clamp(0.0, 1.0);

                    // Calculate translateX based on the distance from the current page
                    translateX =
                        (controller.pageController.page! - index) * 200.0;
                  }

                  return Transform.translate(
                    offset: Offset(translateX, 0.0),
                    child: Opacity(
                      opacity: opacity,
                      child: const Icon(CupertinoIcons.airplane),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: !controller.isSelected.value,
              replacement: const SizedBox(),
              child: const Spacer(),
            ),
            GestureDetector(
              onTap: () {
                controller.toggleExpand();
              },
              child: AnimatedBuilder(
                animation: controller.animationController,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: Colors.black12,
                          width: controller.firstBorderAnimation.value,
                        ),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          controller.thirdRadiusAnimation.value,
                        ),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: black,
                          blurRadius: 1,
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.all(
                        controller.paddingAnimation.value,
                      ),
                      decoration: BoxDecoration(
                        border: const Border.fromBorderSide(
                          BorderSide(color: Colors.black12),
                        ),
                        color: const Color(0XFFDCDCDC),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            controller.secondRadiusAnimation.value,
                          ),
                        ),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.all(controller.paddingAnimation.value),
                        width: controller.widthAnimation.value,
                        height: controller.heightAnimation.value,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                              255, 105, 146, 175), // Couleur de remplissage
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              controller.firstRadiusAnimation.value,
                            ),
                          ),
                          image: !controller.isSelected.value
                              ? DecorationImage(
                                  image: AssetImage(
                                    "assets/images/${destination['image']}",
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          border: Border.all(
                            color: const Color.fromARGB(
                                255, 202, 202, 202), // Couleur de la bordure
                            width: controller.seconBorderdAnimation
                                .value, // Largeur de la bordure
                          ),
                        ),
                        child: controller.isSelected.value &&
                                controller
                                    .videoControllers[index].value.isInitialized
                            ? ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    controller.firstRadiusAnimation.value,
                                  ),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: controller.videoControllers[index]
                                        .value.size.width,
                                    height: controller.videoControllers[index]
                                        .value.size.height,
                                    child: VideoPlayer(
                                      controller.videoControllers[index],
                                    ),
                                  ),
                                ),
                              )
                            : Obx(
                                () {
                                  return SizedBox.expand(
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        AnimatedPositioned(
                                          duration:
                                              const Duration(milliseconds: 400),
                                          left: 0,
                                          right: 0,
                                          top: controller.isOpen.value == false
                                              ? 0
                                              : -310,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              height: 340,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(
                                                color: white,
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/carbonfiber.png",
                                                    ),
                                                    fit: BoxFit.fitHeight),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.isOpen(
                                                        !controller
                                                            .isOpen.value,
                                                      );
                                                      print(controller
                                                          .isOpen.value);
                                                    },
                                                    onVerticalDragStart:
                                                        (details) {
                                                      print(details
                                                          .globalPosition.dy);

                                                      if (details.globalPosition
                                                              .dy >
                                                          300) {
                                                        controller
                                                            .isOpen(false);
                                                      }

                                                      if (details.globalPosition
                                                              .dy >
                                                          500) {
                                                        controller.isOpen(true);
                                                      }
                                                    },
                                                    child: Container(
                                                      margin:
                                                          const EdgeInsets.all(
                                                              8),
                                                      width: 70,
                                                      height: 10,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0XFFDCDCDC),
                                                        border: const Border
                                                            .fromBorderSide(
                                                          BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      31,
                                                                      45,
                                                                      45,
                                                                      45)),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: black,
                                                            blurRadius: 1,
                                                            spreadRadius: 0,
                                                          ),
                                                          BoxShadow(
                                                            color:
                                                                Color.fromARGB(
                                                                    69,
                                                                    78,
                                                                    76,
                                                                    76),
                                                            blurRadius: 10,
                                                            spreadRadius: 3,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: !controller.isSelected.value,
              replacement: const SizedBox(),
              child: const Spacer(),
            ),
            Visibility(
              visible: !controller.isSelected.value,
              replacement: const SizedBox(),
              child: const Spacer(),
            ),
          ],
        );
      },
    );
  }
}
