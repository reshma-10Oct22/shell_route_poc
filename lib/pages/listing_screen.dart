import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shell_router_poc/provider/listing_proivder.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Listing Screen"),
        ),
        body: Consumer<ListProvider>(
          builder: (context, value, child) {
            if (!value.isListLoaded) {
              value.updateList();
            }
            return ListView.builder(
              itemCount: value.generatedList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    value.generatedList[index],
                  ),
                  onTap: () {
                    GoRouter.of(context).go(
                      '/listingScreen/details/${value.generatedList[index]}',
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
