import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:product_app/core/utils/ui/loader.dart';
import 'package:product_app/src/controller/auth_controller.dart';
import 'package:product_app/src/controller/category_controller.dart';
import 'package:product_app/src/controller/profile_controller.dart';
import 'package:product_app/core/theme/app_colors.dart';
import 'package:product_app/core/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/service/routing/app_routes.dart';
import 'package:product_app/core/utils/ui/custom_appbar.dart';
import 'package:product_app/core/utils/ui/custom_scaffold.dart';
import 'package:product_app/core/utils/ui/custom_snackbar.dart';
import 'package:product_app/src/model/category_model.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ProfileController _profileController = Get.find<ProfileController>();
  final AuthController _authController = Get.find<AuthController>();
  final CategoryController _categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: 'ShopNest',
        showBackButton: false,
        actions: [
          IconButton(
            onPressed: () async {
              final error = await _authController.logoutUser();
              if (context.mounted) {
                if (error != null) {
                  CustomSnackbar.show(context, message: error, isError: true);
                } else {
                  CustomSnackbar.show(
                    context,
                    message: 'Logout Successfully!!',
                    isError: false,
                  );
                  context.go(AppRoutes.loginRoute);
                }
              }
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final fullName = _profileController.user.value?.name ?? "";
              final firstName = fullName.trim().split(" ").first;
              return Row(
                children: [
                  Text(
                    'Welcome',
                    style: AppTheme.bodyStyle.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    '$firstName,',
                    style: AppTheme.subHeadingStyle.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            }),
            SizedBox(height: 2.h),

            // Search bar
            TextField(
              onChanged: _categoryController.onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle: AppTheme.bodyStyle,
                border: InputBorder.none,
              ),
              style: AppTheme.bodyStyle,
            ),

            SizedBox(height: 3.h),

            // Category chips
            Text('Categories', style: AppTheme.subHeadingStyle),
            SizedBox(height: 1.5.h),
            Obx(() {
              if (_categoryController.isLoading.value) {
                return Center(child: AppLoader());
              }

              // We inject an "All" category at the start of the list
              final cats = [
                CategoryModel(id: 0, name: 'All'),
                ..._categoryController.categories,
              ];

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: cats.map((cat) {
                    final isSelected =
                        _categoryController.selectedCategoryIdForHome.value ==
                        cat.id;
                    return GestureDetector(
                      onTap: () {
                        // Update the selected category when tapped!
                        _categoryController.selectedCategoryIdForHome.value =
                            cat.id!;
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 2.w),
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.surfaceColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.borderColor,
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          cat.name ?? 'Unknown',
                          style: AppTheme.bodyStyle.copyWith(
                            color: isSelected
                                ? AppColors.whiteColor
                                : AppColors.textSecondary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),

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
            Obx(() {
              final isSearchMode =
                  _categoryController.searchQuery.value.isNotEmpty;
              final products = isSearchMode
                  ? _categoryController.searchResults
                  : _categoryController.filteredHomeProducts;
              if (_categoryController.isLoading.value ||
                  _categoryController.isSearching.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (products.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: Text(
                      'No products found.',
                      style: AppTheme.bodyStyle,
                    ),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
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
                        // Dynamic Image
                        Container(
                          height: 11.h,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.surfaceHighColor,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: p.imageUrl != null
                              ? ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12),
                                  ),
                                  child: Image.network(
                                    p.imageUrl!.startsWith('http')
                                        ? p.imageUrl!
                                        : '${dotenv.env['BASE_URL']?.replaceAll('/api', '')}${p.imageUrl}',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
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
                        Padding(
                          padding: EdgeInsets.all(3.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 0.8.h),
                              Text(
                                p.name ?? 'Unknown',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.bodyStyle.copyWith(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 0.4.h),
                              Text(
                                '₹${p.price ?? 0}',
                                style: AppTheme.bodyStyle.copyWith(
                                  color: AppColors.primaryLight,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    // Add to cart logic will go here!
                                  },
                                  child: Container(
                                    width: 8.w,
                                    height: 4.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: AppColors.whiteColor,
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
              );
            }),

            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
