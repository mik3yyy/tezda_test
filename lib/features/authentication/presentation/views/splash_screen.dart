import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tezda/core/gen/assets.gen.dart';
import 'package:tezda/core/routes/routes.dart';
import 'package:tezda/core/services/providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final hiveDataSource =
        ref.read(authenticationHiveDataSourceProvider); // Access the provider

    final isLoggedIn = await hiveDataSource.isLogin(); // Check login status

    // Delay for splash screen animation
    await Future.delayed(const Duration(seconds: 2));

    // Navigate based on login state
    if (isLoggedIn) {
      context.goNamed(Routes.homeName); // Navigate to Home if logged in
    } else {
      context
          .goNamed(Routes.onboardingName); // Navigate to Onboarding otherwise
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Assets.application.assets.images.splashScreen.image(),
      ),
    );
  }
}
