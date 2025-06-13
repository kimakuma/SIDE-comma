import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/features/auth/pages/login_page.dart';
import '../../presentation/features/auth/pages/splash_screen.dart';
import '../../presentation/shared/navigation/main_navigation.dart';
import '../../presentation/providers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    refreshListenable: router,
    redirect: router._redirect,
    routes: router._routes,
    initialLocation: '/splash',
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen(authProvider, (_, __) => notifyListeners());
  }

  String? _redirect(BuildContext context, GoRouterState state) {
    final isLoggedIn = _ref.read(authProvider).valueOrNull != null;
    final isLoginPage = state.matchedLocation == '/login';
    final isSplashScreen = state.matchedLocation == '/splash';

    if (isSplashScreen) {
      return null;
    }

    if (!isLoggedIn) {
      return isLoginPage ? null : '/login';
    }

    if (isLoginPage) {
      return '/';
    }

    return null;
  }

  List<RouteBase> get _routes => [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const MainNavigation(),
    ),
  ];
} 