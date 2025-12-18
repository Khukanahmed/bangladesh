// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mfm_ebooks/core/const/app_sizes.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_submit_button.dart';
// import 'package:mfm_ebooks/core/global_widegts/custom_text.dart';
// import 'package:mfm_ebooks/core/route/routes.dart';
// import 'package:mfm_ebooks/feature/home/controller/home_controller.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SliderBookCard extends StatelessWidget {
//   SliderBookCard({super.key});
//   final HomeController controller = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Obx(() {
//           if (controller.sliderBooks.isEmpty) {
//             return const SizedBox(
//               height: 164,
//               child: Center(child: CircularProgressIndicator()),
//             );
//           }

//           return CarouselSlider.builder(
//             itemCount: controller.sliderBooks.length,
//             itemBuilder: (context, index, realIdx) {
//               final sliderBook = controller.sliderBooks[index];
//               return Container(
//                 height: 164,
//                 width: double.infinity,
//                 margin: const EdgeInsets.only(
//                   left: 14,
//                   top: 8,
//                   right: 14,
//                   bottom: 10,
//                 ),
//                 padding: const EdgeInsets.only(
//                   left: 24,
//                   top: 12,
//                   right: 24,
//                   bottom: 12,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 3,
//                       spreadRadius: 3,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     // Left Side: Text Content
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CustomText(
//                             text: sliderBook.title,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600,
//                             color: const Color(0xff000000),
//                           ),
//                           SizedBox(height: getHeight(8)),
//                           CustomText(
//                             text: "By ${sliderBook.creator}",
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: const Color(0xff969696),
//                           ),
//                           SizedBox(height: getHeight(12)),

//                           IntrinsicWidth(
//                             child: CustomSubmitButton(
//                               height: getHeight(32),
//                               radius: 8,
//                               text: "explore_now".tr,
//                               fontSize: 14,
//                               textColor: Colors.white,
//                               onTap: () async {
//                                 if (sliderBook.bookId.toString().isNotEmpty) {
//                                   Get.toNamed(
//                                     AppRoutes.detailsPage,
//                                     arguments: {
//                                       'id': sliderBook.bookId,
//                                       'category': "",
//                                     },
//                                   );
//                                 } else {
//                                   final url = Uri.parse(sliderBook.link);
//                                   if (await canLaunchUrl(url)) {
//                                     debugPrint(
//                                       'Launching URL📡📡📡: ${sliderBook.link}',
//                                     );
//                                     await launchUrl(
//                                       url,
//                                       mode: LaunchMode.inAppWebView,
//                                     );
//                                   } else {
//                                     Get.snackbar(
//                                       'Error',
//                                       'Could not launch URL',
//                                       snackPosition: SnackPosition.BOTTOM,
//                                     );
//                                   }
//                                 }
//                               },
//                               bgColor: const Color(0xff151515),
//                               border: Colors.transparent,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     const SizedBox(width: 16),

//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         sliderBook.image,
//                         width: 105,
//                         height: 145,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             options: CarouselOptions(
//               viewportFraction: 1.0,
//               enlargeCenterPage: false,
//               autoPlay: false,
//               onPageChanged: (index, reason) {
//                 controller.changeIndex(index);
//               },
//             ),
//           );
//         }),

//         // Dot Indicator
//         Obx(
//           () => Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               controller.sliderBooks.length,
//               (index) => Container(
//                 width: 8,
//                 height: 8,
//                 margin: const EdgeInsets.symmetric(horizontal: 4),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color:
//                       controller.currentIndex.value == index
//                           ? Colors.purple
//                           : Colors.grey,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
