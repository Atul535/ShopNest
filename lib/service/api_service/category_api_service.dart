import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:product_app/core/constants/api_constants.dart';
import 'package:product_app/service/network_service/dio_client.dart';

abstract class CategoryApiService {
  Future<Either<String, Response>> getAllCategories();
  Future<Either<String, Response>> createCategory({
    required String name,
    String? description,
    String? image,
  });
  Future<Either<String, Response>> updateCategory({
    required int id,
    required String name,
    String? description,
    String? image,
  });
  Future<Either<String, Response>> deleteCategory(int id);
}

class CategoryApiServiceImpl implements CategoryApiService {
  final DioClient _dioClient;

  CategoryApiServiceImpl(this._dioClient);

  @override
  Future<Either<String, Response<dynamic>>> getAllCategories() async {
    try {
      final response = await _dioClient.get(
        ApiConstants.getAllCategoriesEndPoint,
      );
      return right(response);
    } on DioException catch (e) {
      return left(e.response?.data['message'] ?? "No category found!");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Response<dynamic>>> createCategory({
    required String name,
    String? description,
    String? image,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.createCategoryEndPoint,
        data: {
          'name': name,
          if (description != null && description.isNotEmpty)
            'description': description,
          if (image != null && image.isNotEmpty) 'image': image,
        },
      );
      return right(response);
    } on DioException catch (e) {
      return left(e.response?.data['message'] ?? "Failed to create category");
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Response<dynamic>>> updateCategory({
    required int id,
    required String name,
    String? description,
    String? image,
  }) async {
    try {
      final response = await _dioClient.put(
        "${ApiConstants.updateCategoryEndPoint}/$id",
        data: {
          'name': name,
          if (description != null && description.isNotEmpty)
            'description': description,
          if (image != null && image.isNotEmpty) 'image': image,
        },
      );
      return right(response);
    } on DioException catch (e) {
      return left(e.response?.data['message'] ?? "Failed to update category");
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Response<dynamic>>> deleteCategory(int id) async {
    try {
      final response = await _dioClient.delete(
        "${ApiConstants.deleteCategoryEndPoint}/$id",
      );
      return right(response);
    } on DioException catch (e) {
      return left(e.response?.data['message'] ?? "Failed to delete category");
    } catch (e) {
      return left(e.toString());
    }
  }
}
