import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../DesignSystem/Components/BottomTabBar/bottom_tab_bar.dart';
import '../../DesignSystem/Components/BottomTabBar/bottom_tab_bar_view_model.dart';
import '../../resources/shared/app_coordinator.dart';
import '../../resources/shared/colors.dart';

class MainTabFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final viewModel = MainTabViewModel(coordinator: coordinator);
    return MainTabScene(viewModel: viewModel);
  }
}

class MainTabViewModel {
  final AppCoordinator coordinator;
  MainTabViewModel({required this.coordinator});
}

class MainTabScene extends StatefulWidget {
  final MainTabViewModel viewModel;

  const MainTabScene({super.key, required this.viewModel});

  @override
  State<MainTabScene> createState() => _MainTabSceneState();
}

class _MainTabSceneState extends State<MainTabScene> implements BottomTabBarDelegate {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const MatchesPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  @override
  void onIndexChange(int currentIndex) {
    setState(() {
      _currentIndex = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    const BottomTabTheme currentTheme = BottomTabTheme.dark;
    final pageBackgroundColor = currentTheme == BottomTabTheme.dark
        ? brandSecondary.withOpacity(0.9)
        : const Color(0xFFF0F0F0);

    return Scaffold(
      backgroundColor: pageBackgroundColor,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomTabBar.instantiate(
              viewModel: BottomTabBarViewModel(
                theme: currentTheme,
                bottomTabs: [
                  const BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: ""),
                  const BottomNavigationBarItem(icon: Icon(LucideIcons.swords), label: ""),
                  const BottomNavigationBarItem(icon: Icon(LucideIcons.heart), label: ""),
                  const BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: ""),
                ],
              ),
              currentIndex: _currentIndex,
              delegate: this,
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Page', style: TextStyle(color: Colors.white)));
  }
}

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Matches Page', style: TextStyle(color: Colors.white)));
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Favorites Page', style: TextStyle(color: Colors.white)));
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Page', style: TextStyle(color: Colors.white)));
  }
}