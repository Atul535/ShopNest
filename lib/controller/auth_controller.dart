import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:go_router/go_router.dart';
import 'package:product_app/service/api_service/auth_api_service.dart';
import 'package:product_app/service/network_service/local_storage_service.dart';
import 'package:product_app/utils/routing/app_routes.dart';
import 'package:product_app/utils/ui/custom_snackbar.dart';

class AuthController extends GetxController {
  final AuthApiService _authApiService;
  final LocalStorageService _storageService = Get.find<LocalStorageService>();

  AuthController(this._authApiService);

  var isLoading = false.obs;

  Future<void> registerUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    final result = await _authApiService.registerUser(
      name: name,
      email: email,
      password: password,
    );

    if (!context.mounted) {
      isLoading.value = false;
      return;
    }

    result.fold(
      (failure) {
        CustomSnackbar.show(context, message: failure, isError: true);
      },
      (success) {
        CustomSnackbar.show(
          context,
          message: "Registration Success",
          isError: false,
        );
        context.go(AppRoutes.loginRoute);
      },
    );
    isLoading.value = false;
  }

  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    final result = await _authApiService.loginUser(
      email: email,
      password: password,
    );

    if (!context.mounted) {
      isLoading.value = false;
      return;
    }

    result.fold(
      (failure) {
        CustomSnackbar.show(context, message: failure, isError: true);
      },
      (success) {
        String token = success.data['token'];
        _storageService.saveToken(token);
        debugPrint('Token saved successfully: $token');
        if (!context.mounted) return;
        CustomSnackbar.show(
          context,
          message: 'Login Successfully!!',
          isError: false,
        );
        context.go(AppRoutes.homeScreenRoute);
      },
    );
    isLoading.value = false;
  }

  Future<void> logoutUser({required BuildContext context}) async {
    isLoading.value = true;
    final result = await _authApiService.logoutUser();
    if (!context.mounted) {
      isLoading.value = false;
      return;
    }
    result.fold(
      (failure) {
        CustomSnackbar.show(context, message: failure, isError: true);
      },
      (success) async {
        await _storageService.clearToken();
        if (!context.mounted) return;
        CustomSnackbar.show(
          context,
          message: 'Logout Successfully!!',
          isError: false,
        );
        context.go(AppRoutes.loginRoute);
      },
    );
    isLoading.value = false;
  }
}
