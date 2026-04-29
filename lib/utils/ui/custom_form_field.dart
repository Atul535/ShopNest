import 'package:flutter/material.dart';
import 'package:product_app/utils/theme/app_colors.dart';
import 'package:product_app/utils/theme/app_theme.dart';
import 'package:product_app/utils/ui/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool readOnly;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.bodyStyle.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 1.h),
        CustomTextField(
          hintText: hintText,
          controller: controller,
          isReadOnly: readOnly,
          prefixIcon: prefixIcon,
          isPassword: isPassword,
          suffixIcon: suffixIcon,
          keyboardType: keyboardType,
          validator: validator,
        ),
        SizedBox(height: 2.h),
      ],
    );
  }
}
