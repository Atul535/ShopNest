import 'package:flutter/material.dart';
import 'package:product_app/utils/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class AppLoader extends StatefulWidget {
  final Color? color;
  final double? size;
  const AppLoader({super.key, this.color, this.size});

  @override
  _AppLoaderState createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size ?? 50.sp,
        height: widget.size ?? 50.sp,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final delay = index * 0.2;
                final value = Curves.easeInOut.transform(
                  ((_controller.value + delay) % 1.0),
                );
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.w),
                  height: 10.sp * value,
                  width: 10.sp * value,
                  decoration: BoxDecoration(
                    color: (widget.color ?? AppColors.primaryColor).withValues(
                      alpha: 0.2 + value * 0.8,
                    ),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
