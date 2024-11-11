import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tezda/core/extensions/context_extensions.dart';
import 'package:tezda/core/extensions/list_extensions.dart';
import 'package:tezda/core/extensions/widget_extensions.dart';
import 'package:tezda/core/services/providers.dart';
import 'package:tezda/core/states/app_state.dart';
import 'package:tezda/core/utils/validators.dart';
import 'package:tezda/core/widgets/custom_button.dart';
import 'package:tezda/core/widgets/custom_text_field.dart';
import 'package:tezda/features/authentication/data/models/update_user_model.dart';
import 'package:tezda/features/authentication/domain/entities/user.dart';

class UpdateUserScreen extends ConsumerStatefulWidget {
  const UpdateUserScreen({super.key});

  @override
  ConsumerState<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends ConsumerState<UpdateUserScreen>
    with Validators {
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController userNameController;
  late TextEditingController phoneNumberController;

  final updateUserForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    userNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    final userState = ref.read(userNotifierProvider);

    if (userState is SuccessAppState<User>) {
      final user = userState.data!;
      emailController.text = user.email;
      firstNameController.text = user.name.firstname;
      lastNameController.text = user.name.lastname;
      userNameController.text = user.username;
      phoneNumberController.text = user.phone;
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userNotifierProvider);
    ref.listen<AppState<User>>(userNotifierProvider, (previous, current) {
      if (current is SuccessAppState<User>) {
        context.showSnackBar('User details updated successfully!');
        Future.delayed(const Duration(seconds: 2), () {
          context.pop();
        });
      } else if (current is FailureAppState<User>) {
        context.showSnackBar(current.error); // Show error message
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Update Profile",
                style: context.textTheme.displayMedium,
              ),
              Text("Edit your details", style: context.textTheme.bodyMedium),
            ],
          ),
          CustomTextField(
            controller: firstNameController,
            hintText: "i.e John",
            titleText: 'First Name',
            keyboardType: TextInputType.name,
            validator: validateName,
          ),
          CustomTextField(
            controller: lastNameController,
            hintText: "i.e Doe",
            titleText: 'Last Name',
            keyboardType: TextInputType.name,
            validator: validateName,
          ),
          CustomTextField(
            controller: emailController,
            hintText: "i.e john.doe@gmail.com",
            titleText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
          CustomTextField(
            controller: userNameController,
            hintText: "i.e johndoe",
            titleText: 'User Name',
            keyboardType: TextInputType.name,
            validator: validateField,
          ),
          CustomTextField(
            controller: phoneNumberController,
            hintText: "i.e 1234567890",
            titleText: "Phone Number",
            keyboardType: TextInputType.phone,
          ),
        ].addSpacer(const Gap(10)),
      )
          .withCustomPadding()
          .withScrollView()
          .withSafeArea()
          .withForm(updateUserForm),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
            CustomButton(
              label: "Update",
              notifier: ValueNotifier(userState is LoadingAppState),
              onPressed: () async {
                if (!updateUserForm.currentState!.validate()) return;
                final updateUser = UpdateUser(
                  email: emailController.text,
                  username: userNameController.text,
                  name: Name(
                    firstname: firstNameController.text,
                    lastname: lastNameController.text,
                  ),
                  phone: phoneNumberController.text,
                  address: Address(
                    city: "Default City",
                    street: "Default Street",
                    number: 0,
                    zipcode: "00000",
                    geolocation: Geolocation(lat: "0", long: "0"),
                  ),
                );

                await ref
                    .read(userNotifierProvider.notifier)
                    .updateUser(updateUser);
              },
            ),
          ],
        ),
      ),
    );
  }
}
