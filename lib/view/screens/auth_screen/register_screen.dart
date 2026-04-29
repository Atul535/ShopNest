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

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthController _authController = Get.find<AuthController>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(title: 'Create Account', showBackButton: false),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3.h),

              // Header
              Text('Join ShopNest', style: AppTheme.headingStyle),
              SizedBox(height: 0.5.h),
              Text(
                'Best deals on electronics & more',
                style: AppTheme.bodyStyle,
              ),
              SizedBox(height: 4.h),

              CustomFormField(
                label: "Full Name",
                hintText: "Enter your name",
                controller: nameController,
                prefixIcon: Icons.person_outline,
              ),
              CustomFormField(
                label: "Email Address",
                hintText: "Enter your email",
                controller: emailController,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomFormField(
                label: "Password",
                hintText: "Min. 8 characters",
                controller: passwordController,
                prefixIcon: Icons.lock_outline,
                suffixIcon: Icons.visibility_off_outlined,
                isPassword: true,
              ),

              SizedBox(height: 4.h),
              CustomButton(
                text: "Create Account",
                isLoading: _authController.isLoading.value,
                onPressed: () async {
                  final error = await _authController.registerUser(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  if (context.mounted) {
                    if (error != null) {
                      CustomSnackbar.show(context, message: error, isError: true);
                    } else {
                      CustomSnackbar.show(context, message: "Registration Success", isError: false);
                      context.go(AppRoutes.loginRoute);
                    }
                  }
                },
              ),

              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?', style: AppTheme.bodyStyle),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.loginRoute),
                    child: Text(
                      'Sign In',
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
