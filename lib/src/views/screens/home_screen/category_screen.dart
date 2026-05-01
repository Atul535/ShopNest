import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:product_app/core/utils/ui/loader.dart';
import 'package:product_app/src/controller/category_controller.dart';
import 'package:product_app/core/theme/app_colors.dart';
import 'package:product_app/core/theme/app_theme.dart';
import 'package:product_app/core/utils/ui/custom_appbar.dart';
import 'package:product_app/core/utils/ui/custom_scaffold.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  // Get the controller we registered in Dependency Injection
  final CategoryController _categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppbar(
        title: 'All Categories',
        showBackButton: false,
      ),
      body: Obx(() {
        // 1. Show loading spinner
        if (_categoryController.isLoading.value) {
          return const Center(child: AppLoader(color: AppColors.primaryColor));
        }

        // 2. Show empty state if no categories exist
        if (_categoryController.categories.isEmpty) {
          return Center(
            child: Text(
              'No categories found.',
              style: AppTheme.bodyStyle.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          );
        }

        // 3. Display the list of categories!
        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () =>
              _categoryController.getAllCategories(), // Pull to refresh!
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            itemCount: _categoryController.categories.length,
            separatorBuilder: (context, index) => SizedBox(height: 1.5.h),
            itemBuilder: (context, index) {
              final category = _categoryController.categories[index];

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor, width: 0.5),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(2.w),
                  leading: Container(
                    height: 14.w,
                    width: 14.w,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceHighColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: category.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              '${dotenv.env['BASE_URL']?.replaceAll('/api', '')}${category.imageUrl}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.image_not_supported,
                                    color: AppColors.textHint,
                                  ),
                            ),
                          )
                        : Icon(
                            Icons.category,
                            color: AppColors.primaryLight,
                            size: 20.sp,
                          ),
                  ),
                  title: Text(
                    category.name ?? 'Unknown',
                    style: AppTheme.subHeadingStyle.copyWith(fontSize: 14.sp),
                  ),
                  subtitle:
                      category.description != null &&
                          category.description!.isNotEmpty
                      ? Padding(
                          padding: EdgeInsets.only(top: 0.5.h),
                          child: Text(
                            category.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.bodyStyle.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 11.sp,
                            ),
                          ),
                        )
                      : null,
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: AppColors.textHint,
                  ),
                  onTap: () {
                    // Later: Navigate to a screen showing products filtered by this category
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
