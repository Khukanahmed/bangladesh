import 'package:get/get.dart';
import 'package:bangladesh/core/theme/controller/theme_controller.dart';

class ProfileController extends GetxController {
  final ThemeController themeController = Get.find<ThemeController>();

  var name = 'Khukan Miah'.obs;
  var email = 'khukannub99@gmail.com'.obs;
  var number = '01725310335'.obs;
  var profileImage = 'https://avatars.githubusercontent.com/u/90517258?v=4'.obs;

  bool get isDarkMode => themeController.isDarkMode.value;

  void toggleTheme(bool value) {
    themeController.changeTheme(value);
  }
}
