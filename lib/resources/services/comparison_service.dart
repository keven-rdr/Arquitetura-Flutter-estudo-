import 'package:flutter/foundation.dart';
import '../repositories/weapon_repository.dart';
import '../models/weapon_model.dart';

enum ComparisonContext {
  shortRange,
  longRange,
  rawDamage,
}

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

  double _getValue(WeaponModel w, String attr) {
    if (attr == 'Dano') {
      return double.tryParse(w.damage) ?? 0.0;
    }
    if (attr == 'Velocidade') {
      return double.tryParse(w.speed.split(' ')[0]) ?? 0.0;
    }
    if (attr == 'BDMG2') {
      return w.bodyDamageLevel2;
    }
    if (attr == 'PWR') {
      return w.powerValue / 1000.0;
    }
    return 0.0;
  }

  List<String> getWinnersByContext(ComparisonContext context) {
    if (_selectedWeapons.length < 2) return [];

    Map<String, double> weights;

    switch (context) {
      case ComparisonContext.shortRange:weights = {'BDMG2': 0.40, 'Recoil_Recovery': 0.35, 'Velocidade': 0.25};
        break;
      case ComparisonContext.longRange:
        weights = {'PWR': 0.45, 'Velocidade': 0.35, 'BDMG2': 0.20};
        break;
      default:
        weights = {'Dano': 1.0};
    }

    double calculateScore(WeaponModel w) {
      double score = 0;
      weights.forEach((attr, weight) {
        score += _getValue(w, 'BDMG2') * weight;
      });
      return score;
    }

    double maxScore = _selectedWeapons.fold(0.0, (max, w) =>
    (calculateScore(w) > max) ? calculateScore(w) : max
    );

    return _selectedWeapons
        .where((w) => calculateScore(w) == maxScore)
        .map((w) => w.id)
        .toList();
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
