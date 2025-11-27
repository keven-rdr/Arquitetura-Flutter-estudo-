import 'package:flutter/material.dart';
import '../../resources/repositories/weapon_repository.dart';
import '../../resources/services/comparison_service.dart';
import '../../resources/shared/app_coordinator.dart';
import 'home_view.dart';
import 'home_view_model.dart';

class HomeFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final repository = WeaponRepository();
    final comparisonService = ComparisonService();

    final viewModel = HomeViewModel(
      repository: repository,
      comparisonService: comparisonService,
    );
    return HomePage(viewModel: viewModel);
  }
}