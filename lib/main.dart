import 'package:bangladesh/core/const/app_sizes.dart';
import 'package:bangladesh/core/const/language_string.dart';
import 'package:bangladesh/core/route/routes.dart';
import 'package:bangladesh/core/theme/controller/theme_controller.dart';
import 'package:bangladesh/core/theme/view/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(ThemeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return GetMaterialApp(
      title: 'Bangladesh thalassemia foundation',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      fallbackLocale: const Locale("en", "US"),
      translations: LocalString(),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
      builder: EasyLoading.init(),
    );
  }
}
