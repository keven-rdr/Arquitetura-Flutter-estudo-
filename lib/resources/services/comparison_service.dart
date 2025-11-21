import 'package:flutter/foundation.dart';
import '../repositories/weapon_repository.dart';
import '../models/weapon_model.dart';

class ComparisonService extends ChangeNotifier {
  static final ComparisonService _instance = ComparisonService._internal();
  factory ComparisonService() => _instance;
  ComparisonService._internal();

  final WeaponRepository _repo = WeaponRepository();

  List<WeaponModel> _selectedWeapons = [];
  List<WeaponModel> get selectedWeapons => _selectedWeapons;

  final int maxComparisonLimit = 2;

  bool isWeaponSelected(String weaponId) {
    return _selectedWeapons.any((w) => w.id == weaponId);
  }

  void toggleWeapon(String weaponId) {
    if (isWeaponSelected(weaponId)) {
      _selectedWeapons.removeWhere((w) => w.id == weaponId);
    } else {
      if (_selectedWeapons.length < maxComparisonLimit) {
        final weapon = _repo.getById(weaponId);
        if (weapon != null) {
          _selectedWeapons.add(weapon);
        }
      } else {
        print('Limite de $maxComparisonLimit armas atingido.');
      }
    }
    notifyListeners();
  }

  void removeWeapon(String weaponId) {
    _selectedWeapons.removeWhere((w) => w.id == weaponId);
    notifyListeners();
  }

  List<String> getWinners(String attribute) {
    if (_selectedWeapons.isEmpty) return [];

    double getValue(WeaponModel w, String attr) {
      if (attr == 'Dano') {
        return double.tryParse(w.damage) ?? 0.0;
      }
      if (attr == 'Velocidade') {
        return double.tryParse(w.speed.split(' ')[0]) ?? 0.0;
      }
      return 0.0;
    }

    double maxValue = _selectedWeapons.fold(0.0, (max, w) =>
    (getValue(w, attribute) > max) ? getValue(w, attribute) : max
    );

    return _selectedWeapons
        .where((w) => getValue(w, attribute) == maxValue)
        .map((w) => w.id)
        .toList();
  }
}