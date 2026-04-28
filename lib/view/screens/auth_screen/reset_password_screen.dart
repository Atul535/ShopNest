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
import 'package:product_app/view/widgets/otp_input_field.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ResetPasswordScreen extends StatelessWidget {
  final String email;

  ResetPasswordScreen({super.key, required this.email});

  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _otp = '';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(title: 'Reset Password', showBackButton: true),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 3.h),

              // ── Info text ──────────────────────────────────────
              Text(
                "Enter the 6-digit OTP sent to",
                style: AppTheme.bodyStyle.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                email,
                style: AppTheme.bodyStyle.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 4.h),

              // ── OTP boxes ──────────────────────────────────────
              OtpInputField(
                otpLength: 6,
                onChanged: (otp) => _otp = otp,
                onCompleted: (otp) {
                  _otp = otp;
                  // ✅ Auto-focus new password field when OTP is complete
                  FocusScope.of(context).nextFocus();
                },
              ),

              SizedBox(height: 3.h),

              // ── New Password ───────────────────────────────────
              CustomFormField(
                label: 'New Password',
                hintText: 'Enter new password',
                controller: _newPasswordController,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Password is required';
                  if (val.length < 6) return 'Minimum 6 characters';
                  return null;
                },
              ),

              SizedBox(height: 3.h),

              // ── Confirm Password ───────────────────────────────
              CustomFormField(
                label: 'Confirm Password',
                hintText: 'Re-enter new password',
                controller: _confirmPasswordController,
                prefixIcon: Icons.lock_outline,
                isPassword: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please confirm password';
                  }
                  if (val != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),

              SizedBox(height: 4.h),

              // ── Submit ─────────────────────────────────────────
              Obx(
                () => CustomButton(
                  text: 'Reset Password',
                  isLoading: _authController.isLoading.value,
                  onPressed: () {
                    if (_otp.length != 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter the complete OTP'),
                        ),
                      );
                      return;
                    }
                    if (_formKey.currentState!.validate()) {
                      _authController.resetPassword(
                        context: context,
                        email: email,
                        otp: _otp,
                        newPassword: _newPasswordController.text.trim(),
                      );
                    }
                  },
                ),
              ),

              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
