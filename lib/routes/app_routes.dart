import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shell_router_poc/auth/auth.dart';
import 'package:shell_router_poc/pages/dashboard_screen.dart';
import 'package:shell_router_poc/pages/listing_detail_screen.dart';
import 'package:shell_router_poc/pages/listing_screen.dart';
import 'package:shell_router_poc/pages/login_screen.dart';
import 'package:shell_router_poc/pages/scaffold_nav_bar.dart';
import 'package:shell_router_poc/provider/listing_proivder.dart';
import 'package:shell_router_poc/pages/settings_screen.dart';
import 'package:shell_router_poc/bottom_bar_cntrl.dart';

class AppRoutes {
  static GoRouter returnRouter(AuthProvider authProvider) {
    final rootNavigatorKey = GlobalKey<NavigatorState>();
    final listingShellKey =
        GlobalKey<NavigatorState>(debugLabel: 'listingShell');
    final dashboardShellKey =
        GlobalKey<NavigatorState>(debugLabel: 'dashboardShell');
    final settingsShellKey =
        GlobalKey<NavigatorState>(debugLabel: 'settingsShell');

    GoRouter router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/dashboard',
      errorBuilder: (context, state) {
        return const Scaffold(
          body: Text("Error, Page not found"),
        );
      },
      redirect: (context, state) async {
        final bool isSignedIn = await authProvider.getSignInInfo();
        final bool inSignInPage = state.matchedLocation == '/login';
        if (!isSignedIn) {
          return '/login';
        }
        if (isSignedIn && inSignInPage) {
          return '/dashboard';
        }
        return null;
      },
      refreshListenable: authProvider,
      routes: <RouteBase>[
        GoRoute(
          path: '/login',
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (context) => AuthProvider(),
              child: const LoginScreen(),
            );
          },
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNavBar(
              bottomBarCntrl: BottomBarCntrl(),
              navigationShell: navigationShell,
            );
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              navigatorKey: listingShellKey,
              routes: <RouteBase>[
                GoRoute(
                  path: '/listingScreen',
                  builder: (BuildContext context, GoRouterState state) {
                    return ChangeNotifierProvider(
                      create: (context) => ListProvider(),
                      child: const ListingScreen(),
                    );
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'details/:itemId',
                      builder: (BuildContext context, GoRouterState state) {
                        return DetailsScreen(
                          label: state.pathParameters['itemId'] ??
                              "Item id not found",
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: dashboardShellKey,
              routes: [
                GoRoute(
                  path: '/dashboard',
                  builder: (BuildContext context, GoRouterState state) {
                    return const DashboardScreen();
                  },
                  routes: [
                    GoRoute(
                      path: 'details',
                      builder: (BuildContext context, GoRouterState state) {
                        return const DetailsScreen(
                            label: 'Dashboard Detail Screen');
                      },
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: settingsShellKey,
              routes: [
                GoRoute(
                  path: '/settings',
                  builder: (BuildContext context, GoRouterState state) {
                    return const SettingsScreen();
                  },
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'details',
                      builder: (BuildContext context, GoRouterState state) {
                        return const DetailsScreen(
                            label: 'Setting Detail Screen');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
    return router;
  }
}
