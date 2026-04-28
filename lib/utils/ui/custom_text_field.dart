import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:product_app/utils/theme/app_colors.dart';
import 'package:product_app/utils/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final RxBool _obscureText = false.obs;

  CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  }) {
    _obscureText.value = isPassword;
  }
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        controller: controller,
        obscureText: _obscureText.value,
        keyboardType: keyboardType,
        validator: validator,
        style: AppTheme.bodyStyle.copyWith(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTheme.bodyStyle.copyWith(color: AppColors.textHint),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: AppColors.primaryLight, size: 20.sp)
              : null,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                    size: 20.sp,
                  ),
                  onPressed: () {
                    _obscureText.value = !_obscureText.value;
                  },
                )
              : suffixIcon != null
              ? Icon(suffixIcon, color: AppColors.textSecondary, size: 20.sp)
              : null,
          filled: true,
          fillColor: AppColors.surfaceColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.borderColor,
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.errorColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.errorColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
