import 'package:flutter/material.dart';
import 'package:product_app/core/theme/app_colors.dart';
import 'package:product_app/core/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const CustomAppbar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTheme.headingStyle.copyWith(
          fontSize: 20.sp,
          color: AppColors.whiteColor,
        ),
      ),
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 18.sp,
                color: AppColors.whiteColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          : null,
      actions: actions,
      backgroundColor: AppColors.appBarColor,
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(7.h);
}
