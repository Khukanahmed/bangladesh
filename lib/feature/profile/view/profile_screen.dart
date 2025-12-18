import 'package:bangladesh/core/theme/controller/theme_controller.dart';
import 'package:bangladesh/feature/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());
  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(
              () => CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(controller.profileImage.value),
              ),
            ),
            const SizedBox(height: 16),

            Obx(
              () => Text(
                controller.name.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 6),

            Obx(
              () => Text(
                controller.email.value,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
            ),

            const SizedBox(height: 30),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(
                () => SwitchListTile(
                  title: const Text('Dark Mode'),
                  secondary: const Icon(Icons.dark_mode),
                  value: controller.isDarkMode,
                  onChanged: controller.toggleTheme,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
