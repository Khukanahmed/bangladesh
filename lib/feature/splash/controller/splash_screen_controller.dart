import 'dart:async';
import 'package:bangladesh/core/navbar/view/navbar_screen.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  void checkIsLogin() async {
    Timer(const Duration(seconds: 2), () async {
      Get.offAll(() => NewsNavbarScreen());
    });
  }

  @override
  void onInit() {
    super.onInit();

    checkIsLogin();
  }
}
