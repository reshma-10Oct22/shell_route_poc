import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('DASHBOARD'),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/dashboard/details');
              },
              child: const Text('DashBoard Detail'),
            ),
          ],
        ),
      ),
    );
  }
}
