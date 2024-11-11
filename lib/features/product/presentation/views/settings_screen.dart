import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tezda/core/extensions/context_extensions.dart';
import 'package:tezda/core/extensions/widget_extensions.dart';
import 'package:tezda/core/routes/routes.dart';
import 'package:tezda/core/services/providers.dart';
import 'package:tezda/core/states/app_state.dart';
import 'package:tezda/core/utils/image_util.dart';
import 'package:tezda/core/widgets/custom_shimmer.dart';
import 'package:tezda/features/authentication/domain/entities/user.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    final userState = ref.read(userNotifierProvider);

    // Only call fetchProducts if not already in SuccessAppState
    if (userState is! SuccessAppState<User>) {
      Future.microtask(() {
        ref.read(userNotifierProvider.notifier).fetchUserDetails();
      });
    }
  }

  Future<void> clearSpecificHiveBoxes() async {
    final userBox = Hive.box("userBox");
    final favoritesBox = Hive.box<Map>("favorites");

    await userBox.clear(); // Clear all data in userBox
    await favoritesBox.clear(); // Clear all data in favorites
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: userState is LoadingAppState
          ? ComplexShimmer.settingsShimmer()
          : userState is FailureAppState<User>
              ? Center(
                  child: Text('Error: ${userState.error}'),
                )
              : userState is SuccessAppState<User>
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          child: CachedNetworkImage(
                            imageUrl: ImageUtils.profile,
                          ).withClip(50),
                        ),
                        // Greet the user
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Hello, ${userState.data?.username ?? 'User'}!',
                            style: context.textTheme.displayLarge,
                          ),
                        ),

                        const Divider(),

                        // List Buttons
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: const Text('Update Profile'),
                          onTap: () {
                            context.goNamed(Routes.updateProfileName);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.dark_mode),
                          title: const Text('Dark Mode'),
                          trailing: Switch(
                            value:
                                Theme.of(context).brightness == Brightness.dark,
                            onChanged: (value) {},
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Log Out'),
                          onTap: () async {
                            final shouldLogout = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirm Logout'),
                                content: const Text(
                                    'Are you sure you want to log out?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pop(false), // Cancel logout
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => Navigator.of(context)
                                        .pop(true), // Confirm logout
                                    child: const Text('Logout'),
                                  ),
                                ],
                              ),
                            );

                            if (shouldLogout == true) {
                              // Handle logout
                              ref
                                  .read(userNotifierProvider.notifier)
                                  .resetState();
                              ref
                                  .read(authNotifierProvider.notifier)
                                  .resetState();
                              ref
                                  .read(productNotifierProvider.notifier)
                                  .resetState();
                              await clearSpecificHiveBoxes();
                              context.replaceNamed(Routes.loginName);
                            }
                          },
                        ),
                      ],
                    ).withCustomPadding()
                  : const Center(
                      child: Text('No user data available'),
                    ),
    );
  }
}
