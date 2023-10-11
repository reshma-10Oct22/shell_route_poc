import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String label;
  const DetailsScreen({
    required this.label,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Center(
        child: Text(
          label,
          style: const TextStyle(fontSize: 28),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
