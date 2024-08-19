import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.routes,
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.jostTextTheme(),
      ),
    );
  }
}
