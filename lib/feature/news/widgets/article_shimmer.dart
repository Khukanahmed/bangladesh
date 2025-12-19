import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ArticleShimmer extends StatelessWidget {
  const ArticleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.surfaceVariant;
    final highlightColor = theme.colorScheme.surface;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(
            context,
            height: 200,
            width: double.infinity,
            baseColor: baseColor,
            highlightColor: highlightColor,
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(
                  context,
                  width: 120,
                  height: 14,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                ),
                const SizedBox(height: 8),
                _shimmerBox(
                  context,
                  width: double.infinity,
                  height: 18,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                ),
                const SizedBox(height: 6),
                _shimmerBox(
                  context,
                  width: double.infinity,
                  height: 18,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                ),
                const SizedBox(height: 6),
                _shimmerBox(
                  context,
                  width: 200,
                  height: 14,
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox(
    BuildContext context, {
    required double width,
    required double height,
    required Color baseColor,
    required Color highlightColor,
  }) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: const Duration(milliseconds: 1200),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
