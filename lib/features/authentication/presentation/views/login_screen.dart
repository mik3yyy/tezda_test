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

class LoginScreen extends ConsumerStatefulWidget with Validators {
  LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with Validators {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    ref.listen<AppState<void>>(authNotifierProvider, (previous, current) {
      if (current is SuccessAppState) {
        context.goNamed(Routes.homeName); // Navigate to login
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
                "Welcome!",
                style: context.textTheme.displayMedium,
              ),
              Text("please login or sign up to continue our app",
                  style: context.textTheme.bodyMedium),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: userNameController,
                hintText: "i.e mik3yyy",
                titleText: "User Name",
                validator: validateField,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: "",
                isPasswordField: true,
                titleText: "Password",
                // validator: validatePassword,
              ),
            ].addSpacer(const Gap(20)),
          ),
        ].addSpacer(const Gap(20)),
      ).withSafeArea().withCustomPadding().withForm(loginForm),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
            CustomButton(
              label: "Login",
              notifier: ValueNotifier(authState is LoadingAppState),
              onPressed: () async {
                if (!loginForm.currentState!.validate()) return;

                await ref
                    .read(authNotifierProvider.notifier)
                    .login(userNameController.text, passwordController.text);
              },
            ),
            const Gap(10),
            RichText(
              text: TextSpan(
                text: "Don’t have an account? ",
                style: context.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: 'Signup',
                    style: context.textTheme.bodyMedium?.copyWith(
                      decoration: TextDecoration.underline,
                      color: context.primaryColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.goNamed(Routes.signupName);
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
