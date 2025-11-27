import 'package:flutter/material.dart';
import '../../DesignSystem/Components/BottomTabBar/bottom_tab_bar.dart';
import '../../DesignSystem/Components/BottomTabBar/bottom_tab_bar_view_model.dart';
import '../../resources/shared/colors.dart';
import '../Home/home_factory.dart';
import '../profile/profile_factory.dart';
import 'main_tab_factory.dart';
import 'main_tab_view_model.dart';

class MainTabScene extends StatefulWidget {
  final MainTabViewModel viewModel;

  const MainTabScene({super.key, required this.viewModel});

  @override
  State<MainTabScene> createState() => _MainTabSceneState();
}

class _MainTabSceneState extends State<MainTabScene> implements BottomTabBarDelegate {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    widget.viewModel.coordinator.tabNotifier.addListener(_handleTabChangeRequest);

    _pages = [
      HomeFactory.make(coordinator: widget.viewModel.coordinator),
      MatchesFactory.make(coordinator: widget.viewModel.coordinator),
      const Scaffold(body: Center(child: Text("Favoritos"))),
      ProfileFactory.make(coordinator: widget.viewModel.coordinator),
    ];
  }

  @override
  void dispose() {
    widget.viewModel.coordinator.tabNotifier.removeListener(_handleTabChangeRequest);
    super.dispose();
  }

  void _handleTabChangeRequest() {
    final newIndex = widget.viewModel.coordinator.tabNotifier.value;
    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  @override
  void onIndexChange(int currentIndex) {
    setState(() {
      _currentIndex = currentIndex;
      widget.viewModel.coordinator.tabNotifier.value = currentIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.viewModel.bottomTabBarViewModel.theme;
    final pageBackgroundColor = theme == BottomTabTheme.dark
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
              viewModel: widget.viewModel.bottomTabBarViewModel,
              currentIndex: _currentIndex,
              delegate: this,
            ),
          ),
        ],
      ),
    );
  }
}