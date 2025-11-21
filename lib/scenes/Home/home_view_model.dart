import 'package:arqmvvm/resources/repositories/weapon_repository.dart';
import 'package:arqmvvm/resources/services/comparison_service.dart';
import 'package:flutter/material.dart' hide CardTheme;
import 'package:lucide_icons/lucide_icons.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/Components/Card/card_view_model.dart';

class HomeViewModel extends ChangeNotifier {
  final WeaponRepository _repository;
  final ComparisonService _comparisonService;

  HomeViewModel({required WeaponRepository repository, required ComparisonService comparisonService,}) : _repository = repository, _comparisonService = comparisonService {
    _comparisonService.addListener(_onComparisonServiceChange);
    search('');
  }

  void _onComparisonServiceChange() {
    search(_lastQuery);
  }

  String _lastQuery = '';

  @override
  void dispose() {
    _comparisonService.removeListener(_onComparisonServiceChange);
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

      void onComparePressed() {
        _comparisonService.toggleWeapon(weapon.id);
      }

      final IconData compareIcon = isSelected ? LucideIcons.checkCircle : LucideIcons.barChart2;

      final CardTheme cardTheme = isSelected ? CardTheme.dark : CardTheme.dark;

      return InfoCardViewModel(
        theme: cardTheme,
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
              icon: LucideIcons.heart,
              onPressed: () {
                print("Favoritar ${weapon.name} (ID: ${weapon.id})");
              },
            ),
          ),
          CardAction(
            viewModel: ActionButtonViewModel(
              icon: LucideIcons.barChart2,
              onPressed: onComparePressed,
            ),
          ),
        ],
      );
    }).toList();

    _isLoading = false;
    notifyListeners();
  }
}