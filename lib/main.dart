import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:product_app/utils/dependency/dependency_injection.dart';
import 'package:product_app/utils/routing/app_router.dart';
import 'package:product_app/utils/theme/app_theme.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Injection.inject();
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
