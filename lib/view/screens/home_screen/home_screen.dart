import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:product_app/controller/auth_controller.dart';
import 'package:product_app/utils/theme/app_colors.dart';
import 'package:product_app/utils/theme/app_theme.dart';
import 'package:product_app/utils/ui/custom_appbar.dart';
import 'package:product_app/utils/ui/custom_scaffold.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: 'ShopNest',
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () {
              authController.logoutUser(context: context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.h),

            // Search bar
            Container(
              height: 6.h,
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor, width: 0.5),
              ),
              child: Row(
                children: [
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.search,
                    color: AppColors.primaryLight,
                    size: 20.sp,
                  ),
                  SizedBox(width: 3.w),
                  Text('Search products...', style: AppTheme.bodyStyle),
                ],
              ),
            ),

            SizedBox(height: 3.h),

            // Category chips
            Text('Categories', style: AppTheme.subHeadingStyle),
            SizedBox(height: 1.5.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'Phones', 'Laptops', 'Audio', 'Accessories']
                    .asMap()
                    .entries
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.only(right: 2.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: e.key == 0
                              ? AppColors.primaryColor
                              : AppColors.surfaceColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: e.key == 0
                                ? AppColors.primaryColor
                                : AppColors.borderColor,
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          e.value,
                          style: AppTheme.bodyStyle.copyWith(
                            color: e.key == 0
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            SizedBox(height: 3.h),

            // Featured header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Featured deals', style: AppTheme.subHeadingStyle),
                Text(
                  'See all',
                  style: AppTheme.bodyStyle.copyWith(
                    color: AppColors.primaryLight,
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Product grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                final products = [
                  {
                    'name': 'Earbuds Pro',
                    'price': '₹3,299',
                    'old': '₹4,999',
                    'badge': 'Deal',
                  },
                  {
                    'name': 'Smart Watch',
                    'price': '₹7,499',
                    'old': '₹9,999',
                    'badge': 'Hot',
                  },
                  {
                    'name': 'Phone Stand',
                    'price': '₹599',
                    'old': '₹899',
                    'badge': 'New',
                  },
                  {
                    'name': 'USB-C Hub',
                    'price': '₹1,899',
                    'old': '₹2,499',
                    'badge': 'Sale',
                  },
                ];
                final p = products[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.borderColor,
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image placeholder
                      Container(
                        height: 11.h,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceHighColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.devices_other_rounded,
                            color: AppColors.primaryLight,
                            size: 32.sp,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badge
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 2.w,
                                vertical: 0.3.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.badgeBg,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                p['badge']!,
                                style: AppTheme.bodyStyle.copyWith(
                                  color: AppColors.badgeText,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 0.8.h),
                            Text(
                              p['name']!,
                              style: AppTheme.bodyStyle.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 0.4.h),
                            Row(
                              children: [
                                Text(
                                  p['price']!,
                                  style: AppTheme.bodyStyle.copyWith(
                                    color: AppColors.primaryLight,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(width: 1.5.w),
                                Text(
                                  p['old']!,
                                  style: AppTheme.bodyStyle.copyWith(
                                    color: AppColors.textHint,
                                    fontSize: 10.sp,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: AppColors.textHint,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 8.w,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
