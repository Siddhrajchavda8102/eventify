import 'package:event_booking/core/router/app_routes.dart';
import 'package:event_booking/features/auth/presentation/screens/home_page.dart';
import 'package:event_booking/features/auth/presentation/screens/login_page.dart';
import 'package:event_booking/features/auth/presentation/screens/register_page.dart';
import 'package:event_booking/features/splash/presentation/splash_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static GoRouter createRoute() {
    return GoRouter(
      initialLocation: Routes.splash,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.splash,
          name: Routes.splashName,
          builder: (context, state) => const SplashPage(),
        ),
        GoRoute(
          path: Routes.login,
          name: Routes.loginName,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: Routes.register,
          name: Routes.registerName,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: Routes.home,
          name: Routes.homeName,
          builder: (context, state) => const HomePage(),
        ),
      ],
      // errorBuilder: (context, state) => ErrorPage(state: state),
    );
  }
}
