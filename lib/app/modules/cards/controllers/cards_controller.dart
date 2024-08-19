import 'package:get/get.dart';

class CardsController extends GetxController {
  final enterText = "".obs;
  final enteredPassword = "".obs;
  final showCursor = true.obs;
  final count = 0.obs;
  final isIconOnRight = true.obs;
  final isValidated = false.obs;
  void increment() => count.value++;
}
