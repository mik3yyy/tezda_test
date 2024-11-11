import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tezda/core/extensions/context_extensions.dart';
import 'package:tezda/core/extensions/list_extensions.dart';
import 'package:tezda/core/extensions/widget_extensions.dart';
import 'package:tezda/core/gen/assets.gen.dart';
import 'package:tezda/core/routes/routes.dart';
import 'package:tezda/features/authentication/data/models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardingModel> onboardingData = [
    OnboardingModel(
        title: "20% Discount\nNew Arrival Product",
        subTitle:
            "Publish up your selfies to make yourself more beutiful with this app.",
        image: Assets.application.assets.images.ob1),
    OnboardingModel(
        title: "Take Advantage \nOf The Offer Shopping",
        subTitle:
            "Publish up your selfies to make yourself more beutiful with this app.",
        image: Assets.application.assets.images.ob2),
    OnboardingModel(
        title: "All Types Offers \nWithin Your Reach",
        subTitle:
            "Publish up your selfies to make yourself more beutiful with this app.",
        image: Assets.application.assets.images.ob3),
  ];
  PageController _pageController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (value) {
                currentPage = value;
              },
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                OnboardingModel data = onboardingData[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    data.image
                        .image(width: context.screenWidth, fit: BoxFit.cover)
                        .withClip(10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            style: context.textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            data.subTitle,
                            style: context.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: context.colors.greyDecorDark
                                    .withOpacity(.5)),
                          ),
                        ].addSpacer(const Gap(10)))
                  ].addSpacer(const Gap(20)),
                ).withPadding(const EdgeInsets.symmetric(horizontal: 10));
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothPageIndicator(
                controller: _pageController,
                count: onboardingData.length,
                effect: WormEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  dotColor: context.colors.greyDecor,
                  activeDotColor: context.colors.black,
                ),
              ),
              CircleAvatar(
                backgroundColor: context.colors.black,
                radius: 25,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: context.colors.white,
                  size: 30,
                ),
              ).withOnTap(() {
                if (currentPage == 2) {
                  context.goNamed(Routes.loginName);
                }
                currentPage++;
                _pageController.animateToPage(
                  currentPage,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              })
            ],
          ).withPadding(const EdgeInsets.symmetric(horizontal: 10))
        ],
      ).withCustomPadding().withSafeArea(),
    );
  }
}
