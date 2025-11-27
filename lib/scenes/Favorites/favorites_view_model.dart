import 'package:flutter/material.dart' hide CardTheme;
import 'package:lucide_icons/lucide_icons.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/Components/Card/card_view_model.dart';
import '../../resources/repositories/weapon_repository.dart';
import 'favorites_service.dart';

class FavoritesViewModel extends ChangeNotifier {
  final FavoritesService _favoritesService;
  final WeaponRepository _repository;

  FavoritesViewModel({
    required FavoritesService favoritesService,
    required WeaponRepository repository,
  })  : _favoritesService = favoritesService,
        _repository = repository {
    _favoritesService.addListener(_loadFavorites);
    _loadFavorites();
  }

  List<InfoCardViewModel> cards = [];

  @override
  void dispose() {
    _favoritesService.removeListener(_loadFavorites);
    super.dispose();
  }

  void _loadFavorites() {
    final ids = _favoritesService.favoriteIds;

    final favoriteWeapons = ids
        .map((id) => _repository.getById(id))
        .whereType<dynamic>()
        .toList();

    cards = favoriteWeapons.map((weapon) {
      return InfoCardViewModel(
        theme: CardTheme.dark,
        imagePath: weapon!.imagePath,
        title: weapon.name,
        details: {
          'Tipo': weapon.type,
          'Dano': weapon.damage,
        },
        actions: [
          CardAction(
            viewModel: ActionButtonViewModel(
              style: ActionButtonStyle.ghost,
              icon: LucideIcons.heart,
              onPressed: () {
                _favoritesService.toggleFavorite(weapon.id);
              },
            ),
          ),
        ],
      );
    }).toList();

    notifyListeners();
  }
}