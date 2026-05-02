import 'package:get/get.dart';
import 'package:product_app/service/api_service/auth_api_service.dart';
import 'package:product_app/service/network_service/local_storage_service.dart';

class AuthController extends GetxController {
  final AuthApiService _authApiService;
  final LocalStorageService _storageService = Get.find<LocalStorageService>();

  AuthController(this._authApiService);

  RxBool isLoading = false.obs;

  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      final result = await _authApiService.registerUser(
        name: name,
        email: email,
        password: password,
      );
      return result.fold(
        (failure) => failure,
        (success) => null, // null means no error
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      final result = await _authApiService.loginUser(
        email: email,
        password: password,
      );
      return result.fold((failure) => failure, (success) {
        _storageService.saveToken(success.data['token']);
        _storageService.saveRefreshToken(success.data['refreshToken']);
        return null; // null means no error
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> logoutUser() async {
    isLoading.value = true;
    try {
      final result = await _authApiService.logoutUser();
      return result.fold((failure) => failure, (success) async {
        await _storageService.clearToken();
        await _storageService.clearRefreshToken();
        return null;
      });
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> forgetPassword({required String email}) async {
    isLoading.value = true;
    try {
      final result = await _authApiService.forgetPassword(email: email);
      return result.fold((failure) => failure, (success) => null);
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    isLoading.value = true;
    try {
      final result = await _authApiService.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
      return result.fold((failure) => failure, (success) => null);
    } finally {
      isLoading.value = false;
    }
  }
}
