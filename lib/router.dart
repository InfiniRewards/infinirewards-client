import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinirewards/models/app_state.dart';
import 'package:infinirewards/models/user.dart';
import 'package:infinirewards/providers/app_state.dart';
import 'package:infinirewards/providers/user_provider.dart';
import 'package:infinirewards/screens/auth_screen.dart';
import 'package:infinirewards/screens/home_screen.dart';
import 'package:infinirewards/screens/merchant/merchant_dashboard_screen.dart';
import 'package:infinirewards/screens/points/merchant_points_screen.dart';
import 'package:infinirewards/screens/merchant/merchant_screen.dart';
import 'package:infinirewards/screens/vouchers/merchant_vouchers_screen.dart';
import 'package:infinirewards/screens/points/points_screen.dart';
import 'package:infinirewards/screens/points/transfer_points_screen.dart';
import 'package:infinirewards/screens/profile_screen.dart';
import 'package:infinirewards/screens/vouchers/vouchers_screen.dart';
import 'package:infinirewards/screens/splash_screen.dart';
import 'package:infinirewards/screens/not_found_screen.dart';
import 'package:infinirewards/screens/create_account_screen.dart';
import 'package:infinirewards/screens/collectibles/collectibles_screen.dart';
import 'package:infinirewards/screens/memberships/memberships_screen.dart';
import 'package:infinirewards/screens/collectibles/merchant_collectibles_screen.dart';
import 'package:infinirewards/screens/memberships/merchant_memberships_screen.dart';
import 'package:infinirewards/screens/collectibles/collectible_details_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    refreshListenable: router,
    redirect: router._redirect,
    routes: router._routes,
    errorBuilder: router.errorBuilder,
    navigatorKey: _rootNavigatorKey,
  );
});

// First create a RouterNotifier to handle state changes properly
class RouterNotifier extends ChangeNotifier {
  final Ref ref;
  late AppStateData _appState;
  late AsyncValue<User?> _user;

  RouterNotifier(this.ref) {
    _appState = ref.read(appStateProvider);
    _user = ref.read(userNotifierProvider);

    ref.listen(appStateProvider, (_, next) {
      _appState = next;
      notifyListeners();
    });
    ref.listen(userNotifierProvider, (_, next) {
      _user = next;
      notifyListeners();
    });
  }

  String? _redirect(BuildContext context, GoRouterState state) {
    final isAuth = _appState.isAuth;
    final isMerchant = _appState.isMerchant;
    final isAutoLogin = _appState.autoLoginResult;
    final isSplashScreen = state.matchedLocation == '/splash';

    if (!isAuth) return '/auth';

    final needsAccount = _user.whenOrNull(
      data: (user) =>
          user?.accountAddress == null || user?.accountAddress == "",
      loading: () => null,
      error: (_, __) => false,
    );

    if (isAutoLogin == null) return '/splash';
    if (needsAccount == true) return '/create-account';
    if (isSplashScreen && isAutoLogin == true) return '/';

    // Handle merchant mode navigation
    if (isMerchant) {
      if (!state.matchedLocation.startsWith('/merchant')) {
        return '/merchant';
      }
    } else {
      if (state.matchedLocation.startsWith('/merchant')) {
        return '/';
      }
    }

    return null;
  }

  List<RouteBase> get _routes => [
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/auth',
          builder: (context, state) => const AuthScreen(),
        ),
        GoRoute(
          path: '/create-account',
          builder: (context, state) => const CreateAccountScreen(),
        ),

        // User Routes
        ShellRoute(
          builder: (context, state, child) => HomeScreen(child: child),
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const PointsScreen(),
              routes: [
                GoRoute(
                  path: 'transfer',
                  builder: (context, state) => const TransferPointsScreen(),
                ),
              ],
            ),
            GoRoute(
              path: '/collectibles',
              builder: (context, state) => const CollectiblesScreen(),
              routes: [
                GoRoute(
                  path: 'vouchers',
                  builder: (context, state) => const VouchersScreen(),
                ),
                GoRoute(
                  path: 'memberships',
                  builder: (context, state) => const MembershipsScreen(),
                ),
                GoRoute(
                  path: 'details/:id',
                  builder: (context, state) => CollectibleDetailsScreen(
                    id: state.pathParameters['id']!,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),

        // Merchant Routes
        ShellRoute(
          builder: (context, state, child) => MerchantScreen(child: child),
          routes: [
            GoRoute(
              path: '/merchant',
              builder: (context, state) => const MerchantDashboardScreen(),
            ),
            GoRoute(
              path: '/merchant/points',
              builder: (context, state) => const MerchantPointsScreen(),
            ),
            GoRoute(
              path: '/merchant/collectibles',
              builder: (context, state) => const MerchantCollectiblesScreen(),
              routes: [
                GoRoute(
                  path: 'vouchers',
                  builder: (context, state) => const MerchantVouchersScreen(),
                ),
                GoRoute(
                  path: 'memberships',
                  builder: (context, state) =>
                      const MerchantMembershipsScreen(),
                ),
              ],
            ),
            GoRoute(
              path: '/merchant/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ];

  Widget errorBuilder(context, state) => NotFoundScreen(
        message: state.error?.message,
      );
}
