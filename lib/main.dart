import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:product_app/service/network_service/local_storage_service.dart';
import 'package:product_app/core/utils/dependency/dependency_injection.dart';
import 'package:product_app/service/routing/app_router.dart';
import 'package:product_app/core/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Injection.inject();
   final storageService = Get.find<LocalStorageService>();
  final isLoggedIn = await storageService.isLoggedIn();
  // 3. Initialize the router with the login status
  AppRouter.init(isLoggedIn: isLoggedIn);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp.router(
          title: 'Product App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routeInformationParser: AppRouter.router.routeInformationParser,
          routerDelegate: AppRouter.router.routerDelegate,
          routeInformationProvider: AppRouter.router.routeInformationProvider,
          backButtonDispatcher: AppRouter.router.backButtonDispatcher,
        );
      },
    );
  }
}
