import 'package:flutter/material.dart';
import '../../resources/shared/app_coordinator.dart';
import '../../resources/services/comparison_service.dart';
import '../Matches/match_scene.dart';
import '../Matches/matches_view_model.dart';


class MatchesFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final comparisonService = ComparisonService();

    final viewModel = MatchesViewModel(
      comparisonService: comparisonService,
      coordinator: coordinator,
      //he named parameter 'coordinator' isn't defined. (Documentation)
      //
      // Try correcting the name to an existing named parameter's name, or defining a named parameter with the name 'coordinator'.
    );

    return MatchesPage(viewModel: viewModel);
  }
}