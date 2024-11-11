import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tezda/features/authentication/presentation/views/login_screen.dart';
import 'package:tezda/features/authentication/presentation/views/onboarding_page.dart';
import 'package:tezda/features/authentication/presentation/views/signup.dart';
import 'package:tezda/features/authentication/presentation/views/splash_screen.dart';
import 'package:tezda/features/product/domain/entities/product.dart';
import 'package:tezda/features/product/presentation/views/favourite_screen.dart';
import 'package:tezda/features/product/presentation/views/home_screen.dart';
import 'package:tezda/features/product/presentation/views/main_page.dart';
import 'package:tezda/features/product/presentation/views/product_detail.dart';
import 'package:tezda/features/product/presentation/views/settings_screen.dart';
import 'package:tezda/features/product/presentation/views/update_user.dart';

// Define route constants
class Routes {
  static const String splashPath = '/';
  static const String splashName = '/';
  static const String onboardingPath = '/onboarding';
  static const String onboardingName = 'onboarding';
  static const String loginPath = '/login';
  static const String loginName = 'login';
  static const String signupPath = '/signup';
  static const String signupName = 'signup';

  static const String homePath = '/home';
  static const String homeName = 'home';

  static const String favouritePath = '/favourite';
  static const String favouriteName = 'favourite';
  static const String settingsPath = '/settings';
  static const String settingsName = 'settings';
  static const String productDetailPath = 'productDetail';
  static const String productDetailName = 'productDetail';

  static const String updateProfilePath = 'updateProfile';
  static const String updateProfileName = 'updateProfile';

  static const String productDetailFName = 'productDetailF';
  // Navigator keys for nested navigation
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        path: splashPath,
        name: splashName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onboardingPath,
        name: onboardingName,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: loginPath,
        name: loginName,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: signupPath,
        name: signupName,
        builder: (context, state) => SignupScreen(),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => MainPage(
          child: child,
        ),
        routes: [
          GoRoute(
              path: homePath,
              name: homeName,
              parentNavigatorKey: shellNavigatorKey,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: HomeScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
              routes: [
                GoRoute(
                  path: productDetailPath,
                  name: productDetailName,
                  parentNavigatorKey: rootNavigatorKey,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: ProductDetail(
                        product: state.extra as Product,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    );
                  },
                ),
              ]),
          GoRoute(
              path: favouritePath,
              name: favouriteName,
              parentNavigatorKey: shellNavigatorKey,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const FavouriteScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                );
              },
              routes: [
                GoRoute(
                  path: productDetailPath,
                  name: productDetailFName,
                  parentNavigatorKey: rootNavigatorKey,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      key: state.pageKey,
                      child: ProductDetail(
                        product: state.extra as Product,
                      ),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    );
                  },
                ),
              ]),
          GoRoute(
            path: settingsPath,
            name: settingsName,
            parentNavigatorKey: shellNavigatorKey,
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const SettingsScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            },
            routes: [
              GoRoute(
                path: updateProfilePath,
                name: updateProfileName,
                parentNavigatorKey: rootNavigatorKey,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: const UpdateUserScreen(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
