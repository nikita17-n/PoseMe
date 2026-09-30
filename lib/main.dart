import 'package:flutter/material.dart';

import 'screens/favorites_screen.dart';
import 'screens/home_screen.dart';
import 'screens/live_camera_screen.dart';
import 'screens/pose_discovery_screen.dart';
import 'screens/profile_screen.dart';
import 'theme/app_theme.dart';
import 'utils/pose_page_route.dart';
import 'widgets/bottom_nav.dart';

void main() {
  runApp(const PoseMeApp());
}

class PoseMeApp extends StatelessWidget {
  const PoseMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PoseMe',
      theme: AppTheme.light,
      home: const MainShell(),
    );
  }
}

/// Root shell hosting the five main tabs with the bottom navigation bar.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  static const _tabs = [
    HomeScreen(),
    PoseDiscoveryScreen(),
    LiveCameraScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    if (index == 2) {
      // Camera tab opens the live camera screen as its own flow.
      Navigator.of(context)
          .push(PosePageRoute(builder: (_) => const LiveCameraScreen()));
      return;
    }
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: PoseBottomNav(
        currentIndex: _index,
        onTap: _onTabSelected,
      ),
    );
  }
}
