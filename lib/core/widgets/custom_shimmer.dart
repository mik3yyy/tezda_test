import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ComplexShimmer {
  static Widget settingsShimmer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular Profile Picture Shimmer
          Row(
            children: [
              FadeShimmer.round(
                size: 60,
                fadeTheme: FadeTheme.light,
                millisecondsDelay: 0,
              ),
              const SizedBox(width: 16),
              // Name Shimmer
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeShimmer(
                    height: 16,
                    width: 120,
                    millisecondsDelay: 20,
                    radius: 8,
                    fadeTheme: FadeTheme.light,
                  ),
                  const SizedBox(height: 8),
                  FadeShimmer(
                    height: 12,
                    width: 180,
                    millisecondsDelay: 40,
                    radius: 8,
                    fadeTheme: FadeTheme.light,
                  ),
                ],
              ),
            ],
          ),
          const Gap(32),

          // List Item Shimmers (3 items)
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              itemBuilder: (_, i) {
                final delay = i * 20;
                return Row(
                  children: [
                    FadeShimmer.round(
                      size: 40,
                      fadeTheme: FadeTheme.light,
                      millisecondsDelay: delay,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FadeShimmer(
                        height: 16,
                        width: double.infinity,
                        millisecondsDelay: delay,
                        radius: 8,
                        fadeTheme: FadeTheme.light,
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Generic shimmer for list items
  static Widget listShimmer({required int itemCount, double height = 80}) {
    return ListView.separated(
      itemCount: itemCount,
      itemBuilder: (_, i) {
        final delay = i * 20;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              FadeShimmer.round(
                size: 50,
                fadeTheme: FadeTheme.light,
                millisecondsDelay: delay,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeShimmer(
                      height: 12,
                      width: double.infinity,
                      millisecondsDelay: delay,
                      radius: 4,
                      fadeTheme: FadeTheme.light,
                    ),
                    const SizedBox(height: 8),
                    FadeShimmer(
                      height: 12,
                      width: MediaQuery.of(_).size.width * 0.6,
                      millisecondsDelay: delay,
                      radius: 4,
                      fadeTheme: FadeTheme.light,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
    );
  }
}
