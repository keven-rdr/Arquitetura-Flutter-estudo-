import 'package:arqmvvm/resources/repositories/weapon_repository.dart';
import 'package:arqmvvm/resources/services/comparison_service.dart';
import 'package:flutter/material.dart' hide CardTheme;
import 'package:lucide_icons/lucide_icons.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/Components/Card/card_view_model.dart';
import '../favorites/favorites_service.dart';

class HomeViewModel extends ChangeNotifier {
  final WeaponRepository _repository;
  final ComparisonService _comparisonService;
  final FavoritesService _favoritesService;

  HomeViewModel({
    required WeaponRepository repository,
    required ComparisonService comparisonService,
    required FavoritesService favoritesService,
  })  : _repository = repository,
        _comparisonService = comparisonService,
        _favoritesService = favoritesService {

    _comparisonService.addListener(_refreshSearch);
    _favoritesService.addListener(_refreshSearch);

    search('');
  }

  void _refreshSearch() {
    search(_lastQuery);
  }

  String _lastQuery = '';

  @override
  void dispose() {
    _comparisonService.removeListener(_refreshSearch);
    _favoritesService.removeListener(_refreshSearch);
    super.dispose();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<InfoCardViewModel> _cards = [];
  List<InfoCardViewModel> get cards => _cards;

  Future<void> search(String query) async {
    _lastQuery = query;
    _isLoading = true;
    notifyListeners();

    final weapons = await _repository.searchWeapons(query);

    _cards = weapons.map((weapon) {
      final isSelected = _comparisonService.isWeaponSelected(weapon.id);
      final isFavorite = _favoritesService.isFavorite(weapon.id);

      final IconData compareIcon = isSelected ? LucideIcons.checkCircle : LucideIcons.barChart2;

      final IconData favoriteIcon = LucideIcons.heart;

      final ActionButtonStyle favoriteStyle = isFavorite
          ? ActionButtonStyle.destructive
          : ActionButtonStyle.ghost;

      return InfoCardViewModel(
        theme: CardTheme.dark,
        isSelected: isSelected,
        imagePath: weapon.imagePath,
        title: weapon.name,
        details: {
          'Tipo': weapon.type,
          'Dano': weapon.damage,
          'Velocidade': weapon.speed,
        },
        actions: [
          CardAction(
            viewModel: ActionButtonViewModel(
              style: favoriteStyle,
              icon: favoriteIcon,
              onPressed: () {
                _favoritesService.toggleFavorite(weapon.id);
              },
            ),
          ),
          CardAction(
            viewModel: ActionButtonViewModel(
              icon: compareIcon,
              onPressed: () {
                _comparisonService.toggleWeapon(weapon.id);
              },
            ),
          ),
        ],
      );
    }).toList();

    _isLoading = false;
    notifyListeners();
  }
}