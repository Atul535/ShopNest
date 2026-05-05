import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:product_app/src/model/category_model.dart';
import 'package:product_app/core/theme/app_colors.dart';
import 'package:product_app/core/theme/app_theme.dart';
import 'package:product_app/core/utils/ui/custom_appbar.dart';
import 'package:product_app/core/utils/ui/custom_scaffold.dart';
import 'package:sizer/sizer.dart';

class CategoryProductsScreen extends StatelessWidget {
  final CategoryModel category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: category.name ?? 'Products',
        showBackButton: true,
      ),
      body: category.products == null || category.products!.isEmpty
          ? Center(
              child: Text(
                'No products found in this category.',
                style: AppTheme.bodyStyle.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            )
          : GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              itemCount: category.products!.length,
              itemBuilder: (context, index) {
                final product = category.products![index];

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
                      // Product Image
                      Container(
                        height: 14.h,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceHighColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: product.imageUrl != null
                            ? ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.network(
                                  product.imageUrl!.startsWith('http')
                                      ? product.imageUrl!
                                      : '${dotenv.env['BASE_URL']?.replaceAll('/api', '')}${product.imageUrl}',
                                  fit: BoxFit.cover,

                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        Icons.image_not_supported,
                                        color: AppColors.textHint,
                                        size: 32.sp,
                                      ),
                                ),
                              )
                            : Icon(
                                Icons.devices_other_rounded,
                                color: AppColors.primaryLight,
                                size: 32.sp,
                              ),
                      ),

                      // Product Details
                      Padding(
                        padding: EdgeInsets.all(3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name ?? 'Unknown',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.bodyStyle.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              // Adjust the currency symbol if needed!
                              '₹${product.price ?? 0}',
                              style: AppTheme.bodyStyle.copyWith(
                                color: AppColors.primaryLight,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            // Quick Add Button (placeholder for now)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.all(1.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
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
    );
  }
}
