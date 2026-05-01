import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:product_app/service/network_service/dio_client.dart';
import 'package:product_app/core/constants/api_constants.dart';

abstract class ProfileApiService {
  Future<Either<String, Response>> getUser();
  Future<Either<String, Response>> getAllUsers();
  Future<Either<String, Response>> updateProfile({
    String? name,
    String? oldPassword,
    String? newPassword,
  });
}

class ProfileApiServiceImpl implements ProfileApiService {
  final DioClient _dioClient;
  ProfileApiServiceImpl(this._dioClient);

  @override
  Future<Either<String, Response>> getAllUsers() async {
    try {
      final response = await _dioClient.get(ApiConstants.getAllUsersEndPoint);
      return Right(response);
    } on DioException catch (e) {
      return left(e.response?.data['message'] ?? "No registered user found");
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Response>> getUser() async {
    try {
      final response = await _dioClient.get(ApiConstants.getUserEndPoint);
      return right(response);
    } on DioException catch (e) {
      return left(e.response?.data['message'] ?? "No user found!");
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Response>> updateProfile({
    String? name,
    String? oldPassword,
    String? newPassword,
  }) async {
    try {
      final Map<String, dynamic> data = {};
      if (name != null && name.isNotEmpty) {
        data['name'] = name;
      }
      if (oldPassword != null && oldPassword.isNotEmpty) {
        data['oldPassword'] = oldPassword;
      }
      if (newPassword != null && newPassword.isNotEmpty) {
        data['newPassword'] = newPassword;
      }

      final response = await _dioClient.put(
        ApiConstants.updateProfileEndPoint,
        data: data,
      );
      return right(response);
    } on DioException catch (e) {
      return left(e.response?.data['message'] ?? 'Failed to update profile!');
    } catch (e) {
      return left(e.toString());
    }
  }
}
