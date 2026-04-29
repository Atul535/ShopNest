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
  final _profileController = Get.find<ProfileController>();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Prefill if user already loaded
    final user = _profileController.user.value;
    if (user != null) {
      _nameController.text = user.name ?? '';
      _emailController.text = user.email ?? '';
    }

    // Sync controllers when user data loads asynchronously
    ever(_profileController.user, (user) {
      if (user != null) {
        if (_nameController.text.isEmpty) {
          _nameController.text = user.name ?? '';
        }
        if (_emailController.text.isEmpty) {
          _emailController.text = user.email ?? '';
        }
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    final error = await _profileController.updateProfile(
      name: _nameController.text.trim(),
      oldPassword: _oldPasswordController.text,
      newPassword: _newPasswordController.text,
    );

    if (!mounted) return;

    if (error != null) {
      _showSnackbar(error, isError: true);
    } else {
      _showSnackbar('Profile updated successfully!', isError: false);
      _oldPasswordController.clear();
      _newPasswordController.clear();
    }
  }

  void _showSnackbar(String message, {required bool isError}) =>
      CustomSnackbar.show(context, message: message, isError: isError);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppbar(title: 'Edit Profile', showBackButton: false),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 2.h),
              _buildAvatar(),
              SizedBox(height: 3.h),
              _buildPersonalDetails(),
              SizedBox(height: 3.h),
              _buildChangePassword(),
              SizedBox(height: 4.h),
              Obx(
                () => CustomButton(
                  text: 'Save Changes',
                  isLoading: _profileController.isLoading.value,
                  onPressed: _onSave,
                ),
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Center(
      child: CircleAvatar(
        radius: 40.sp,
        backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
        child: Icon(Icons.person, size: 40.sp, color: AppColors.primaryColor),
      ),
    );
  }

  Widget _buildPersonalDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Personal Details', style: AppTheme.subHeadingStyle),
        SizedBox(height: 2.h),
        CustomFormField(
          label: 'Full Name',
          hintText: 'Enter your full name',
          controller: _nameController,
          prefixIcon: Icons.person_outline,
          validator: (val) =>
              val == null || val.isEmpty ? 'Name cannot be empty' : null,
        ),
        SizedBox(height: 2.h),
        CustomFormField(
          label: 'Email Address',
          hintText: 'Email address',
          controller: _emailController,
          prefixIcon: Icons.email_outlined,
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildChangePassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
      ],
    );
  }
}
