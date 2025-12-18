// import 'package:flutter/material.dart';
// import 'package:mfm_ebooks/core/const/app_colors.dart';
// import 'package:mfm_ebooks/core/const/image_path.dart';
// import 'package:shimmer/shimmer.dart';

// class CustomShimmerImage extends StatelessWidget {
//   final String? image;
//   final double? height;
//   final double? width;
//   final Widget? errorImage;
//   final double? borderWidth;
//   final Color? color;

//   const CustomShimmerImage({
//     super.key,
//     required this.image,
//     this.height,
//     this.width,
//     this.errorImage,
//     this.borderWidth,
//     this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width ?? 124,
//       height: height ?? 124,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(
//           color: color ?? AppColors.white,
//           width: borderWidth ?? 3,
//         ),
//       ),
//       child: ClipOval(
//         child:
//             (image != null && image!.isNotEmpty)
//                 ? Image.network(
//                   image!,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: double.infinity,
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Shimmer.fromColors(
//                       baseColor: Colors.grey[300]!,
//                       highlightColor: Colors.grey[100]!,
//                       child: Container(
//                         width: double.infinity,
//                         height: double.infinity,
//                         color: Colors.white,
//                       ),
//                     );
//                   },
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       width: double.infinity,
//                       height: double.infinity,
//                       color: Colors.grey,
//                       child:
//                           errorImage ??
//                           // Image.asset(ImagePath.profile, fit: BoxFit.cover),
//                     );
//                   },
//                 )
//                 : Image.asset(
//                   // ImagePath.profile,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: double.infinity,
//                 ),
//       ),
//     );
//   }
// }
