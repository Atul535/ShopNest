import 'package:flutter/material.dart';
import 'package:product_app/utils/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final bool showPadding;
  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.showPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: appBar,
        body: SafeArea(
          child: Padding(
            padding: showPadding
                ? EdgeInsetsGeometry.symmetric(horizontal: 5.w, vertical: 2.h)
                : EdgeInsets.zero,
            child: body,
          ),
        ),
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
