import 'package:flutter/material.dart';

enum BottomTabItem {
  listing,
  dashboard,
  settings,
}

class BottomBarCntrl {
  List<BottomTabItem> listOfBottomTab() {
    return [
      BottomTabItem.listing,
      BottomTabItem.dashboard,
      BottomTabItem.settings,
    ];
  }

  Icon getBottomTabIcon(BottomTabItem item) {
    switch (item) {
      case BottomTabItem.listing:
        return const Icon(Icons.list_alt_outlined);
      case BottomTabItem.dashboard:
        return const Icon(Icons.home);
      case BottomTabItem.settings:
        return const Icon(Icons.settings);
    }
  }

  String getBottomTabLabel(BottomTabItem item) {
    switch (item) {
      case BottomTabItem.listing:
        return "Listing";
      case BottomTabItem.dashboard:
        return "Dashboard";
      case BottomTabItem.settings:
        return "Settings";
    }
  }
}
