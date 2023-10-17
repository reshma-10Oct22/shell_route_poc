import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shell_router_poc/bottom_bar_cntrl.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final BottomBarCntrl bottomBarCntrl;
  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
    required this.bottomBarCntrl,
  });

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  List<BottomTabItem> _bottomTabItems = [];
  @override
  void initState() {
    super.initState();
    _bottomTabItems = widget.bottomBarCntrl.listOfBottomTab();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: _buildBottomBar(),
        currentIndex: widget.navigationShell.currentIndex,
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomBar() {
    return _bottomTabItems.map((e) {
      return BottomNavigationBarItem(
        icon: widget.bottomBarCntrl.getBottomTabIcon(e),
        label: widget.bottomBarCntrl.getBottomTabLabel(e),
      );
    }).toList();
  }

  void _onItemTapped(int index, BuildContext context) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }
}
