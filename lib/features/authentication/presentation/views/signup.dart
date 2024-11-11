import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tezda/core/extensions/context_extensions.dart';
import 'package:tezda/core/extensions/list_extensions.dart';
import 'package:tezda/core/extensions/widget_extensions.dart';
import 'package:tezda/core/routes/routes.dart';
import 'package:tezda/core/services/providers.dart';
import 'package:tezda/core/states/app_state.dart';
import 'package:tezda/core/utils/validators.dart';
import 'package:tezda/core/widgets/custom_button.dart';
import 'package:tezda/core/widgets/custom_text_field.dart';
import 'package:tezda/features/authentication/domain/entities/address.dart';
import 'package:tezda/features/authentication/domain/entities/geoloacation.dart';
import 'package:tezda/features/authentication/domain/entities/name.dart';
import 'package:tezda/features/authentication/domain/usecases/create_account.dart';
import 'package:tezda/features/authentication/presentation/widgets/success_widget.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> with Validators {
  TextEditingController emailController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController cpasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final signupForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    ref.listen<AppState<void>>(authNotifierProvider, (previous, current) {
      if (current is SuccessAppState) {
        showDialog(
          useSafeArea: false,
          context: context,
          builder: (context) => SuccessfulWidget(
            text: "Sign up Successful, Login",
            onTap: () {
              context.pop(); // Close dialog
              context.goNamed(Routes.loginName); // Navigate to login
            },
          ),
        );
      } else if (current is FailureAppState<void>) {
        context.showSnackBar(current.error); // Accessing the error string here
      }
    });

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FlutterLogo(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sign Up!",
                style: context.textTheme.displayMedium,
              ),
              Text("create an new account",
                  style: context.textTheme.bodyMedium),
            ],
          ),
          CustomTextField(
            controller: firstNameController,
            hintText: "i.e mike",
            titleText: 'First Name',
            keyboardType: TextInputType.name,
            validator: validateName,
          ),
          CustomTextField(
            controller: lastNameController,
            hintText: "i.e okpechi",
            titleText: 'Last Name',
            keyboardType: TextInputType.name,
            validator: validateName,
          ),
          CustomTextField(
            controller: emailController,
            hintText: "i.e mikeokpechi@gmail.com",
            titleText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
          CustomTextField(
            controller: userNameController,
            hintText: "i.e mikeyy",
            titleText: 'User name',
            keyboardType: TextInputType.name,
            validator: validateField,
          ),
          CustomTextField(
            controller: phoneNumberController,
            hintText: "i.e 07017079122",
            titleText: "Phone number",
            keyboardType: TextInputType.number,
            validator: validateDigit,
          ),
          CustomTextField(
            controller: passwordController,
            hintText: "i.e mikeyy",
            titleText: 'Password',
            isPasswordField: true,
            keyboardType: TextInputType.visiblePassword,
            validator: validatePassword,
          ),
          CustomTextField(
            controller: cpasswordController,
            isPasswordField: true,
            validator: (value) => validateConfirmPassword(
                passowrd: passwordController.text, confirmPassword: value),
            titleText: "Confirm Password",
            hintText: "",
          ),
        ].addSpacer(const Gap(10)),
      )
          .withCustomPadding()
          .withScrollView()
          .withSafeArea()
          .withForm(signupForm),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
            CustomButton(
              label: "Signup",
              notifier: ValueNotifier(authState is LoadingAppState),
              onPressed: () async {
                if (!signupForm.currentState!.validate()) return;
                final params = CreateAccountParams(
                  email: emailController.text,
                  username: userNameController.text,
                  password: passwordController.text,
                  name: Name(
                    firstname: firstNameController.text,
                    lastname: lastNameController.text,
                  ),
                  address: Address(
                    city: "Default City",
                    street: "Default Street",
                    number: 0,
                    zipcode: "00000",
                    geolocation: Geolocation(lat: "0", long: "0"),
                  ),
                  phone: phoneNumberController.text,
                );
                await ref.read(authNotifierProvider.notifier).signup(params);
              },
            ),
            const Gap(10),
            RichText(
              text: TextSpan(
                text: "Do you have an account? ",
                style: context.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: 'Login',
                    style: context.textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.underline,
                      color: context.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.goNamed(Routes.loginName);
                      },
                  ),
                ],
              ),
            ).toTop().toCenter(),
          ],
        ),
      ),
    );
  }
}
