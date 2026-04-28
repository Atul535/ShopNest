import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:product_app/service/network_service/dio_client.dart';

abstract class AuthApiService {
  Future<Either<String, Response>> registerUser({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<String, Response>> loginUser({
    required String email,
    required String password,
  });
  Future<Either<String, Response>> logoutUser();
}

class AuthApiServiceImpl implements AuthApiService {
  final DioClient _dioClient;

  AuthApiServiceImpl(this._dioClient);

  @override
  Future<Either<String, Response>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        '/auth/register',
        data: {'name': name, 'email': email, 'password': password},
      );
      return right(response);
    } on DioException catch (e) {
      // 🔍 Debug — print full response to see what server says
      debugPrint('STATUS: ${e.response?.statusCode}');
      debugPrint('DATA: ${e.response?.data}');
      debugPrint('HEADERS: ${e.response?.headers}');
      final data = e.response?.data;
      String errorMsg = "Something went wrong";
      if (data != null) {
        if (data is Map) {
          errorMsg = data['message'] ?? data['error'] ?? errorMsg;
        } else if (data is String) {
          errorMsg = data;
        }
      }
      return left(errorMsg);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Response>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      return right(response);
    } on DioException catch (e) {
      // 🔍 Debug — print full response to see what server says
      debugPrint('STATUS: ${e.response?.statusCode}');
      debugPrint('DATA: ${e.response?.data}');
      debugPrint('HEADERS: ${e.response?.headers}');
      final data = e.response?.data;
      String errorMsg = "Something went wrong";
      if (data != null) {
        if (data is Map) {
          errorMsg = data['message'] ?? data['error'] ?? errorMsg;
        } else if (data is String) {
          errorMsg = data;
        }
      }
      return left(errorMsg);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Response>> logoutUser() async {
    try {
      final response = await _dioClient.post('/auth/logout');
      return right(response);
    } on DioException catch (e) {
      return left(e.response?.data['message'] ?? 'Logout Failed!');
    } catch (e) {
      return left(e.toString());
    }
  }
}
