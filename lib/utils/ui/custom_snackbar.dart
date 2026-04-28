import 'package:flutter/material.dart';
import 'package:product_app/utils/theme/app_colors.dart';
import 'package:product_app/utils/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
  }) {
    final snackbar = SnackBar(
      content: Row(
        children: [
          Icon(isError ? Icons.error_outline : Icons.check_circle_outline),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              message,
              style: AppTheme.bodyStyle.copyWith(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: isError ? AppColors.errorColor : AppColors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.all(16.sp),
      duration: const Duration(seconds: 3),
      elevation: 6,
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
