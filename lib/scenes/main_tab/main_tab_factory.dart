import '../../resources/shared/app_coordinator.dart';
import 'main_tab_scene.dart';
import 'package:flutter/cupertino.dart';
import 'main_tab_view_model.dart';

class MainTabFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final viewModel = MainTabViewModel(coordinator: coordinator);
    return MainTabScene(viewModel: viewModel);
  }
}

