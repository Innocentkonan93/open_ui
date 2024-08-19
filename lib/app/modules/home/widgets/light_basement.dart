import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class LightBasement extends StatelessWidget {
  const LightBasement({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenHeight = size.height;
    final screenWidth = size.width;

    final theme = context.theme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: screenHeight / 4,
          width: 4,
          decoration: const BoxDecoration(color: Colors.grey),
        ),
        Container(
          width: 15,
          height: 5,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Container(
          width: 30,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(4),
            ),
          ),
        ),
        Container(
          width: 42,
          height: 8,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 90, 63, 63),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Container(
          width: 35,
          height: 10,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 23, 23, 23),
          ),
        ),
        Container(
          width: 55,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(4),
            ),
          ),
        ),
        Container(
          width: screenWidth / 2.3,
          height: screenHeight / 14,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            gradient: LinearGradient(colors: [
              theme.primaryColor,
              Colors.white,
              theme.primaryColor,
            ], stops: const [
              .1,
              .5,
              .9
            ]),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(100),
            ),
          ),
        ),
        Container(
          width: screenWidth / 2.25,
          height: 2,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 57, 57, 57),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(100),
            ),
          ),
        ),
      ],
    ).animate().slideY(
          duration: const Duration(milliseconds: 600),
          curve: Curves.bounceOut,
        );
  }
}
