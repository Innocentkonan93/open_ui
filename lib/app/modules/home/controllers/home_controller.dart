import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  PageController pageController = PageController(viewportFraction: 1);

  final isSelected = false.obs;

  final isStart = true.obs;
  final isViewOpen = false.obs;

  var currentIndex = 0.obs;

  var isPlaneAnimationRunning = false.obs;

  var isOpen = false.obs;

  // Rxn<Duration> videoDuration = Rxn<Duration>();

  late AnimationController animationController;
  late Animation<double> widthAnimation;
  late Animation<double> heightAnimation;
  late Animation<double> firstRadiusAnimation;
  late Animation<double> secondRadiusAnimation;
  late Animation<double> thirdRadiusAnimation;
  late Animation<double> paddingAnimation;
  late Animation<double> firstBorderAnimation;
  late Animation<double> seconBorderdAnimation;

  List<VideoPlayerController> videoControllers = [];

  @override
  void onInit() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    const double initialWidth = 220.0;
    const double initialHeight = 340.0;
    final double maxWidth = MediaQuery.of(Get.context!).size.width;
    final double maxHeight = MediaQuery.of(Get.context!).size.height;

    widthAnimation = Tween<double>(begin: initialWidth, end: maxWidth)
        .animate(animationController);
    heightAnimation = Tween<double>(begin: initialHeight, end: maxHeight - 2)
        .animate(animationController);
    firstRadiusAnimation =
        Tween<double>(begin: 90.0, end: 0.0).animate(animationController);
    secondRadiusAnimation =
        Tween<double>(begin: 110.0, end: 0.0).animate(animationController);
    thirdRadiusAnimation =
        Tween<double>(begin: 130.0, end: 0.0).animate(animationController);
    paddingAnimation =
        Tween<double>(begin: 20.0, end: 0.0).animate(animationController);
    firstBorderAnimation =
        Tween<double>(begin: 2.0, end: 0.0).animate(animationController);
    seconBorderdAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(animationController);

    for (var destination in destinations) {
      VideoPlayerController videoController =
          VideoPlayerController.asset("assets/videos/${destination['video']}")
            ..initialize().then((_) {
              update();
            });
      videoControllers.add(videoController);
    }

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        videoControllers[currentIndex.value].play();
      } else if (status == AnimationStatus.dismissed) {
        videoControllers[currentIndex.value].pause();
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    animationController.dispose();
    for (var videoController in videoControllers) {
      videoController.dispose();
    }
    super.dispose();
  }

  void toggleExpand() async {
    // await getVideoDuration();
    if (!animationController.isCompleted) {
      isSelected(true);
      await animationController.forward();
      isPlaneAnimationRunning.value = true;

      isViewOpen(true);
    } else {
      isViewOpen(false);
      await animationController.reverse();
      videoControllers[currentIndex.value].initialize();
      isSelected(false);
      isPlaneAnimationRunning.value = false;
    }
    debugPrint(currentIndex.toString());
  }

  final destinations = <Map<String, dynamic>>[
    {
      "id": 0,
      "name": "Paris",
      "image": "paris.png",
      "video": "Paris..mp4",
      "price": 340.0,
    },
    {
      "id": 1,
      "name": "Abidjan",
      "image": "abidjan.png",
      "video": "Abidjan..mp4",
      "price": 512.0,
    },
    {
      "id": 2,
      "name": "New York",
      "image": "newyork.png",
      "video": "Newyork..mp4",
      "price": 219.0,
    },
    {
      "id": 3,
      "name": "Tokyo",
      "image": "tokyo.png",
      "video": "Tokyo.mp4",
      "price": 209.0,
    },
    {
      "id": 4,
      "name": "Dubaï",
      "image": "dubai.png",
      "video": "Dubai.mp4",
      "price": 420.0,
    }
  ].obs;

  // Future<void> getVideoDuration() async {
  //   videoDuration.value = videoControllers[currentIndex.value].value.duration;
  // }
}
