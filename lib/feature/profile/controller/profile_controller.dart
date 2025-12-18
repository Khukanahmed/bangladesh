import 'package:get/get.dart';
import 'package:bangladesh/core/theme/controller/theme_controller.dart';

class ProfileController extends GetxController {
  final ThemeController themeController = Get.find<ThemeController>();

  var name = 'Khukan Ahmed'.obs;
  var email = 'khukannub99@gmail.com'.obs;
  var profileImage = 'https://i.pravatar.cc/300'.obs;

  bool get isDarkMode => themeController.isDarkMode.value;

  void toggleTheme(bool value) {
    themeController.changeTheme(value);
  }
}
