import 'package:go_router/go_router.dart';
import 'package:product_app/service/routing/app_routes.dart';
import 'package:product_app/src/views/screens/auth_screen/forget_password_screen.dart';
import 'package:product_app/src/views/screens/auth_screen/login_screen.dart';
import 'package:product_app/src/views/screens/auth_screen/register_screen.dart';
import 'package:product_app/src/views/screens/auth_screen/reset_password_screen.dart';
import 'package:product_app/src/views/screens/home_screen/cart_screen.dart';
import 'package:product_app/src/views/screens/home_screen/category_screen.dart';
import 'package:product_app/src/views/screens/home_screen/home_screen.dart';
import 'package:product_app/src/views/screens/profile/profile_screen.dart';
import 'package:product_app/src/views/widgets/main_wrapper.dart';

class AppRouter {
  static late final GoRouter router;

  static void init({required bool isLoggedIn}) {
    router = GoRouter(
      initialLocation: isLoggedIn
          ? AppRoutes.homeScreenRoute
          : AppRoutes.loginRoute,
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
          path: AppRoutes.forgetPasswordRoute,
          builder: (context, state) => ForgetPasswordScreen(),
        ),
        GoRoute(
          path: AppRoutes.resetPasswordRoute,
          builder: (context, state) =>
              ResetPasswordScreen(email: state.extra as String),
        ),

        // Bottom Navigation Bar Routes
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainWrapper(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.homeScreenRoute,
                  builder: (context, state) => HomeScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.categoryRoute,
                  builder: (context, state) => CategoryScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.cartRoute,
                  builder: (context, state) => CartScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: AppRoutes.profileRoute,
                  builder: (context, state) => ProfileScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
