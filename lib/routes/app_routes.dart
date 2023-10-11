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

class AppRoutes {
  static GoRouter returnRouter(AuthProvider authProvider) {
    final GlobalKey<NavigatorState> rootNavigatorKey =
        GlobalKey<NavigatorState>(debugLabel: 'root');
    final GlobalKey<NavigatorState> shellNavigatorKey =
        GlobalKey<NavigatorState>(debugLabel: 'shell');

    GoRouter router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/dashboard',
      errorBuilder: (context, state) {
        return const Scaffold(
          body: Text("Error"),
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
      routes: [
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) {
            return MaterialPage(
              child: ChangeNotifierProvider(
                create: (context) => AuthProvider(),
                child: const LoginScreen(),
              ),
            );
          },
        ),
        ShellRoute(
          navigatorKey: shellNavigatorKey,
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return ScaffoldWithNavBar(child: child);
          },
          routes: <RouteBase>[
            GoRoute(
              path: '/listingScreen',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return MaterialPage(
                  child: ChangeNotifierProvider(
                    create: (context) => ListProvider(),
                    child: const ListingScreen(),
                  ),
                );
              },
              routes: <RouteBase>[
                GoRoute(
                  parentNavigatorKey: rootNavigatorKey,
                  path: 'details/:itemId',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return MaterialPage(
                      child: DetailsScreen(
                        label: state.pathParameters["itemId"]!,
                      ),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/dashboard',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage(
                  child: DashboardScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: 'details',
                  parentNavigatorKey: rootNavigatorKey,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const MaterialPage(
                      child: DetailsScreen(label: 'Dashboard Detail Screen'),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/settings',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return const MaterialPage(
                  child: SettingsScreen(),
                );
              },
              routes: <RouteBase>[
                GoRoute(
                  path: 'details',
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return const MaterialPage(
                      child: DetailsScreen(label: 'Setting Detail Screen'),
                    );
                  },
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
