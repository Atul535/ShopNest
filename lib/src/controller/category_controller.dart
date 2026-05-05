import 'dart:async';

import 'package:get/get.dart';
import 'package:product_app/service/api_service/category_api_service.dart';
import 'package:product_app/src/model/category_model.dart';
import 'package:product_app/src/model/product_model.dart';

class CategoryController extends GetxController {
  final CategoryApiService _categoryApiService;

  CategoryController(this._categoryApiService);

  final RxBool isLoading = false.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxInt selectedCategoryIdForHome = 0.obs;
  final RxString searchQuery = ''.obs;
  final RxList<ProductModel> searchResults = <ProductModel>[].obs;
  final RxBool isSearching = false.obs;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<String?> getAllCategories() async {
    isLoading.value = true;
    try {
      final result = await _categoryApiService.getAllCategories();
      return result.fold((failure) => failure, (success) {
        final List data = success.data['data'] as List;
        categories.value = data
            .map((json) => CategoryModel.fromJson(json as Map<String, dynamic>))
            .toList();
        return null;
      });
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> createCategory({
    required String name,
    String? description,
    String? image,
  }) async {
    isLoading.value = true;
    try {
      final result = await _categoryApiService.createCategory(
        name: name,
        description: description,
        image: image,
      );
      return result.fold((failure) => failure, (success) async {
        await getAllCategories();
        return null;
      });
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> updateCategory({
    required int id,
    required String name,
    String? description,
    String? image,
  }) async {
    isLoading.value = true;
    try {
      final result = await _categoryApiService.updateCategory(
        id: id,
        name: name,
        description: description,
        image: image,
      );
      return result.fold((failure) => failure, (success) async {
        await getAllCategories();
        return null;
      });
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> deleteCategory(int id) async {
    isLoading.value = true;
    try {
      final result = await _categoryApiService.deleteCategory(id);
      return result.fold((failure) => failure, (success) async {
        await getAllCategories();
        return null;
      });
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String query) {
    // update tracker whatever the user types in the search bar
    searchQuery.value = query;
    // If the timer is already running (because they typed a letter a split-second ago),
    // we cancel it! This prevents us from spamming the server 3 times for "M", "MA", and "MAC".
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    // 3. If they hit backspace until the box is empty, clear the results and stop.
    if (query.isEmpty) {
      searchResults.clear();
      isSearching.value == false;
      return;
    }
    // 4. THE DELAY (The actual Debounce logic)
    // We start a 500 millisecond (half-second) countdown timer.
    // If the user types another letter before the timer hits 0, Step 2 will cancel this timer.
    // But if the user STOPS typing for half a second, the timer finishes and triggers the API!
    _debounce = Timer(const Duration(), () {
      searchProductsRemote(query);
    });
  }

  Future<void> searchProductsRemote(String query) async {
    isSearching.value = true;
    try {
      final result = await _categoryApiService.searchProducts(query);
      result.fold(
        (failure) {
          searchResults.clear();
        },
        (success) {
          final List data = success.data['data'] as List;
          searchResults.value = data
              .map(
                (json) => ProductModel.fromJson(json as Map<String, dynamic>),
              )
              .toList();
        },
      );
    } finally {
      isSearching.value = false;
    }
  }

  List get filteredHomeProducts {
    if (selectedCategoryIdForHome.value == 0) {
      final allProducts = [];
      for (var cat in categories) {
        if (cat.products != null) {
          allProducts.addAll(cat.products!);
        }
      }
      return allProducts;
    } else {
      final selectedCat = categories.firstWhere(
        (c) => c.id == selectedCategoryIdForHome.value,
        orElse: () => CategoryModel(),
      );
      return selectedCat.products ?? [];
    }
  }
}
