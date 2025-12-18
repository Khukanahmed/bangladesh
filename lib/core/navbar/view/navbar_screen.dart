import 'package:bangladesh/core/navbar/controller/navbar_controller.dart';
import 'package:bangladesh/feature/news/view/news_screen.dart';
import 'package:bangladesh/feature/profile/view/profile_screen.dart';
import 'package:bangladesh/feature/tasks/view/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NewsNavbarScreen extends StatelessWidget {
  NewsNavbarScreen({super.key});

  final controller = Get.put(NewsNavbarController());

  final pages = [TasksScreen(), NewsScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: GNav(
              selectedIndex: controller.currentIndex.value,
              onTabChange: controller.changeTab,
              gap: 8,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              color: Colors.grey,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.red,
              tabs: const [
                GButton(icon: Icons.category, text: 'Tasks'),
                GButton(icon: Icons.public, text: 'News'),
                GButton(icon: Icons.person, text: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
