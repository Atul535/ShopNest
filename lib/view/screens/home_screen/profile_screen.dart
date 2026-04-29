import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_app/controller/profile_controller.dart';
import 'package:product_app/utils/theme/app_colors.dart';
import 'package:product_app/utils/theme/app_theme.dart';
import 'package:product_app/utils/ui/custom_appbar.dart';
import 'package:product_app/utils/ui/custom_button.dart';
import 'package:product_app/utils/ui/custom_form_field.dart';
import 'package:product_app/utils/ui/custom_scaffold.dart';
import 'package:product_app/utils/ui/custom_snackbar.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _profileController = Get.find<ProfileController>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Pre-fill the user's name
    _nameController = TextEditingController(
      text: _profileController.user.value?.name ?? '',
    );
    _emailController = TextEditingController(
      text: _profileController.user.value?.email ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomScaffold(
        appBar: const CustomAppbar(
          title: 'Edit Profile',
          showBackButton: false,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 2.h),

                // ── Profile Avatar Placeholder ──
                Center(
                  child: CircleAvatar(
                    radius: 40.sp,
                    backgroundColor: AppColors.primaryLight.withValues(
                      alpha: 0.2,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 40.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),

                SizedBox(height: 3.h),

                // ── Personal Details ──
                Text('Personal Details', style: AppTheme.subHeadingStyle),
                SizedBox(height: 2.h),

                CustomFormField(
                  label: 'Full Name',
                  hintText: _profileController.user.value?.name ?? 'Loading...',
                  controller: _nameController,
                  prefixIcon: Icons.person_outline,
                  validator: (val) => val == null || val.isEmpty
                      ? 'Name cannot be empty'
                      : null,
                ),

                SizedBox(height: 1.h),

                CustomFormField(
                  label: 'Email Address',
                  hintText:
                      _profileController.user.value?.email ?? 'Loading...',
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  readOnly: true,
                ),

                SizedBox(height: 3.h),

                // ── Change Password ──
                Text('Change Password', style: AppTheme.subHeadingStyle),
                SizedBox(height: 2.h),

                CustomFormField(
                  label: 'Old Password',
                  hintText: 'Required only if changing password',
                  controller: _oldPasswordController,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                ),
                SizedBox(height: 2.h),
                CustomFormField(
                  label: 'New Password',
                  hintText: 'Enter new password',
                  controller: _newPasswordController,
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                ),

                SizedBox(height: 4.h),

                // ── Save Button ──
                CustomButton(
                  text: 'Save Changes',
                  isLoading: _profileController.isLoading.value,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final oldPass = _oldPasswordController.text;
                      final newPass = _newPasswordController.text;

                      // Make sure both password fields are filled if attempting to change it
                      if ((oldPass.isNotEmpty && newPass.isEmpty) ||
                          (oldPass.isEmpty && newPass.isNotEmpty)) {
                        CustomSnackbar.show(
                          context,
                          message:
                              'Please fill both password fields to change your password',
                          isError: true,
                        );
                        return;
                      }

                      // Option B: Call the controller and wait for the returned String error
                      final error = await _profileController.updateProfile(
                        name: _nameController.text.trim(),
                        oldPassword: oldPass,
                        newPassword: newPass,
                      );

                      if (context.mounted) {
                        if (error != null) {
                          CustomSnackbar.show(
                            context,
                            message: error,
                            isError: true,
                          );
                        } else {
                          CustomSnackbar.show(
                            context,
                            message: 'Profile updated successfully!',
                            isError: false,
                          );

                          // Clear the password fields so they don't remain populated
                          _oldPasswordController.clear();
                          _newPasswordController.clear();
                        }
                      }
                    }
                  },
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
