import 'package:flutter/material.dart';
import '../../DesignSystem/Components/BottomTabBar/bottom_tab_bar_view_model.dart'; // Import necessário
import '../../resources/shared/app_coordinator.dart';

class MainTabViewModel {
  final AppCoordinator coordinator;

  final BottomTabBarViewModel bottomTabBarViewModel;

  MainTabViewModel({
    required this.coordinator,
    required this.bottomTabBarViewModel,
  });
}