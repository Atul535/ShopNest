import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:product_app/controller/auth_controller.dart';
import 'package:product_app/utils/theme/app_colors.dart';
import 'package:product_app/utils/theme/app_theme.dart';
import 'package:product_app/utils/ui/custom_appbar.dart';
import 'package:product_app/utils/ui/custom_button.dart';
import 'package:product_app/utils/ui/custom_form_field.dart';
import 'package:product_app/utils/ui/custom_scaffold.dart';
import 'package:sizer/sizer.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(title: 'Forget Password', showBackButton: true),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 3.h),
              Text(
                "Enter you registered email",
                style: AppTheme.bodyStyle.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              CustomFormField(
                label: 'Email',
                hintText: 'Enter your email',
                controller: _emailController,
                prefixIcon: Icons.email_rounded,
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val!.isEmpty ? "Email is required" : null,
              ),
              SizedBox(height: 4.h),
              Obx(
                () => CustomButton(
                  text: 'Send Otp',
                  isLoading: _authController.isLoading.value,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _authController.forgetPassword(
                        context: context,
                        email: _emailController.text.trim(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
