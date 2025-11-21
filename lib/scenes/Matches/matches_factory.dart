import 'package:flutter/material.dart';
import '../../resources/services/comparison_service.dart';
import '../../resources/shared/app_coordinator.dart';
import 'match_scene.dart';
import 'matches_view_model.dart';

class MatchesFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final comparisonService = ComparisonService();
    final viewModel = MatchesViewModel(
      comparisonService: comparisonService,
    );
    return MatchesPage(viewModel: viewModel);
  }
}