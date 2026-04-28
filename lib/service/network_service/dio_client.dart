import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:product_app/service/network_service/local_storage_service.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  final LocalStorageService _storageService = LocalStorageService();
  late Dio _dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.get('BASE_URL'),
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        responseType: ResponseType.json,
      ),
    );

    // Add Interceptors for Auth and Logging
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await _storageService.getToken();

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          debugPrint('API ERROR: ${e.message}');
          return handler.next(e);
        },
      ),
    );
  }

  // --- API Methods ---

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }

  // Helper for Multipart/Image Uploads
  Future<Response> postWithImage(String path, FormData formData) async {
    return await _dio.post(
      path,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }
}
