import 'package:flutter/material.dart';
import '../../DesignSystem/Components/BottomTabBar/bottom_tab_bar_view_model.dart';
import '../../resources/shared/app_coordinator.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../main_tab/main_tab_scene.dart';
import '../main_tab/main_tab_view_model.dart';


class MainTabFactory {
  static Widget make({required AppCoordinator coordinator}) {

    final tabBarViewModel = BottomTabBarViewModel(
      theme: BottomTabTheme.dark,
      bottomTabs: [
        const BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: ""),
        const BottomNavigationBarItem(icon: Icon(LucideIcons.swords), label: ""),
        const BottomNavigationBarItem(icon: Icon(LucideIcons.heart), label: ""),
        const BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: ""),
      ],
    );

    final viewModel = MainTabViewModel(
      bottomTabBarViewModel: tabBarViewModel,
      coordinator: coordinator,
    );

    return MainTabScene(viewModel: viewModel);
  }
}