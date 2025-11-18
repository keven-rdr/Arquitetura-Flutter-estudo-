import 'package:arqmvvm/repositories/weapon_repository.dart';
import 'package:flutter/material.dart' hide CardTheme;
import 'package:lucide_icons/lucide_icons.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/Components/Card/card_view_model.dart';

class HomeViewModel extends ChangeNotifier {
  final WeaponRepository _repository;

  HomeViewModel({required WeaponRepository repository}) : _repository = repository{
    search('');
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<InfoCardViewModel> _cards = [];
  List<InfoCardViewModel> get cards => _cards;

  Future<void> search(String query) async {
    _isLoading = true;
    notifyListeners();

    final weapons = await _repository.searchWeapons(query);

    _cards = weapons.map((weapon) {
      return InfoCardViewModel(
        theme: CardTheme.dark,
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
              onPressed: () {
                print("Comparar ${weapon.name}");
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