import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:product_app/model/user_model.dart';
import 'package:product_app/service/api_service/profile_api_service.dart';

class ProfileController extends GetxController {
  final ProfileApiService _profileApiService;

  ProfileController(this._profileApiService);

  RxBool isLoading = false.obs;
  final Rxn<UserModel> user = Rxn<UserModel>();
  final RxList<UserModel> allUsers = <UserModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    getMyProfile();
  }

  Future<void> getMyProfile() async {
    isLoading.value = true;
    try {
      final result = await _profileApiService.getUser();
      result.fold(
        (failure) {
          debugPrint("Failed to fetch profile: $failure");
        },
        (success) {
          user.value = UserModel.fromJson(success.data);
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> getAllProfile() async {
    isLoading.value = true;
    try {
      final result = await _profileApiService.getAllUsers();
      return result.fold(
        (failure) => failure,
        (success) {
          final List data = success.data as List;
          allUsers.value = data
              .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
              .toList();
          return null; // null means no error
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> updateProfile({
    required String name,
    required String oldPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;
    try {
      final result = await _profileApiService.updateProfile(
        name: name,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return result.fold(
        (failure) => failure,
        (success) async {
          await getMyProfile();
          return null; // null means no error
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
