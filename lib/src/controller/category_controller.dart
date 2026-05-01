import 'package:get/get.dart';
import 'package:product_app/service/api_service/category_api_service.dart';
import 'package:product_app/src/model/category_model.dart';

class CategoryController extends GetxController {
  final CategoryApiService _categoryApiService;

  CategoryController(this._categoryApiService);

  final RxBool isLoading = false.obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

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
}
