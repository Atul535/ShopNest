import 'package:go_router/go_router.dart';
import 'package:product_app/utils/routing/app_routes.dart';
import 'package:product_app/view/screens/auth_screen/forget_password_screen.dart';
import 'package:product_app/view/screens/auth_screen/login_screen.dart';
import 'package:product_app/view/screens/auth_screen/register_screen.dart';
import 'package:product_app/view/screens/auth_screen/reset_password_screen.dart';
import 'package:product_app/view/screens/home_screen/home_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.loginRoute,
    routes: [
      GoRoute(
        path: AppRoutes.loginRoute,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.registerRoute,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.homeScreenRoute,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgetPasswordRoute,
        builder: (context, state) => ForgetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.resetPasswordRoute,
        builder: (context, state) =>
            ResetPasswordScreen(email: state.extra as String),
      ),
    ],
  );
}
