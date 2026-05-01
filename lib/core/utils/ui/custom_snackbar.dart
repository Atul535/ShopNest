import 'package:flutter/material.dart';
import 'package:product_app/core/theme/app_colors.dart';
import 'package:product_app/core/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    bool isInfo = false,
  }) {
    IconData iconData;
    Color bgColor;

    if (isError) {
      iconData = Icons.error_outline;
      bgColor = AppColors.errorColor;
    } else if (isInfo) {
      iconData = Icons.info_outline;
      bgColor = AppColors.saleColor;
    } else {
      iconData = Icons.check_circle_outline;
      bgColor = AppColors.green;
    }

    final snackbar = SnackBar(
      content: Row(
        children: [
          Icon(iconData, color: AppColors.whiteColor),
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
      backgroundColor: bgColor,
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
