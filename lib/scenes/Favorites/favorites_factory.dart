import 'package:flutter/material.dart';
import '../../resources/repositories/weapon_repository.dart';
import '../../resources/shared/app_coordinator.dart';
import 'favorites_scene.dart';
import 'favorites_service.dart';
import 'favorites_view_model.dart';

class FavoritesFactory {
  static Widget make({required AppCoordinator coordinator}) {
    final favoritesService = FavoritesService();
    final repository = WeaponRepository();

    final viewModel = FavoritesViewModel(
      favoritesService: favoritesService,
      repository: repository,
    );

    return FavoritesPage(viewModel: viewModel);
  }
}