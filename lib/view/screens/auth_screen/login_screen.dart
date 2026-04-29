import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/controller/auth_controller.dart';
import 'package:product_app/utils/theme/app_colors.dart';
import 'package:product_app/utils/routing/app_routes.dart';
import 'package:product_app/utils/theme/app_theme.dart';
import 'package:product_app/utils/ui/custom_appbar.dart';
import 'package:product_app/utils/ui/custom_button.dart';
import 'package:product_app/utils/ui/custom_form_field.dart';
import 'package:product_app/utils/ui/custom_scaffold.dart';
import 'package:product_app/utils/ui/custom_snackbar.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(title: 'Login', showBackButton: false),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3.h),

              // Header
              Text('Welcome back', style: AppTheme.headingStyle),
              SizedBox(height: 0.5.h),
              Text('Sign in to continue shopping', style: AppTheme.bodyStyle),
              SizedBox(height: 4.h),

              CustomFormField(
                label: "Email Address",
                hintText: "Enter your email",
                controller: emailController,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomFormField(
                label: "Password",
                hintText: "Enter your password",
                controller: passwordController,
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icons.visibility_off_outlined,
                isPassword: true,
              ),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    context.push(AppRoutes.forgetPasswordRoute);
                  },
                  child: Text(
                    'Forgot password?',
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 3.h),
              CustomButton(
                text: "Sign In",
                isLoading: _authController.isLoading.value,
                onPressed: () async {
                  final error = await _authController.loginUser(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  if (context.mounted) {
                    if (error != null) {
                      CustomSnackbar.show(context, message: error, isError: true);
                    } else {
                      CustomSnackbar.show(context, message: 'Login Successfully!!', isError: false);
                      context.go(AppRoutes.homeScreenRoute);
                    }
                  }
                },
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: AppTheme.bodyStyle),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.registerRoute),
                    child: Text(
                      'Register',
                      style: AppTheme.bodyStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
