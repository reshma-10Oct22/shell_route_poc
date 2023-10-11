import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shell_router_poc/auth/auth.dart';
import 'package:shell_router_poc/routes/app_routes.dart';

void main() {
  runApp(ShellRouteExampleApp());
}

class ShellRouteExampleApp extends StatelessWidget {
  ShellRouteExampleApp({super.key});
  final _authProvider = AuthProvider();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>.value(
      value: _authProvider,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.returnRouter(_authProvider),
      ),
    );
  }
}
