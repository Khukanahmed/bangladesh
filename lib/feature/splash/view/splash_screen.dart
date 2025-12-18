import 'package:bangladesh/core/const/app_colors.dart';
import 'package:bangladesh/core/const/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          Center(
            child: SizedBox(
              height: 226,
              width: 226,
              child: Image.asset(ImagePath.splashImg),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: SpinKitCircle(color: AppColors.primaryColor, size: 90),
            ),
          ),
        ],
      ),
    );
  }
}
