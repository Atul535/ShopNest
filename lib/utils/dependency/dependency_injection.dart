import 'package:get/get.dart';
import 'package:product_app/controller/auth_controller.dart';
import 'package:product_app/controller/profile_controller.dart';
import 'package:product_app/service/api_service/auth_api_service.dart';
import 'package:product_app/service/api_service/profile_api_service.dart';
import 'package:product_app/service/network_service/dio_client.dart';
import 'package:product_app/service/network_service/local_storage_service.dart';

class Injection {
  static void inject() {
    initialBindings();
  }

  static void initialBindings() {
    // ========== Network Layer ==========
    Get.lazyPut<DioClient>(() => DioClient());
    Get.lazyPut<LocalStorageService>(() => LocalStorageService());

    // ========== Service Layer ==========
    Get.lazyPut<AuthApiService>(
      () => AuthApiServiceImpl(Get.find<DioClient>()),
    );
    Get.lazyPut<ProfileApiService>(
      () => ProfileApiServiceImpl(Get.find<DioClient>()),
    );

    // ========== Controller Layer ==========
    Get.lazyPut<AuthController>(
      () => AuthController(Get.find<AuthApiService>()),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(Get.find<ProfileApiService>()),
    );
  }
}
