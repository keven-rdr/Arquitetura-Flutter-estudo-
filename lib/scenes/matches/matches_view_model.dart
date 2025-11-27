import 'package:flutter/material.dart';
import '../../DesignSystem/Components/ValueComparisonCard/value_comparison_card_view_model.dart';
import '../../DesignSystem/Components/ComparasionPlatform/comparasion_platform_view_model.dart';
import '../../resources/models/weapon_model.dart';
import '../../resources/services/comparison_service.dart';
import '../../resources/shared/app_coordinator.dart';

enum ComparisonContext {
  rawDamage,
  shortRangeTTK,
  longRangeAccuracy,
  powerComparison
}

class MatchesViewModel extends ChangeNotifier {
  final ComparisonService _comparisonService;
  final AppCoordinator _coordinator;

  MatchesViewModel({
    required ComparisonService comparisonService,
    required AppCoordinator coordinator,
  }) : _comparisonService = comparisonService,
        _coordinator = coordinator {
    _comparisonService.addListener(notifyListeners);
  }

  List<WeaponModel> get selectedWeapons => _comparisonService.selectedWeapons;
  int get limit => _comparisonService.maxComparisonLimit;
  bool get canCompare => selectedWeapons.length >= 2;

  @override
  void dispose() {
    _comparisonService.removeListener(notifyListeners);
    super.dispose();
  }

  void removeWeapon(String id) {
    _comparisonService.removeWeapon(id);
  }

  void addMoreWeapons() {
    _coordinator.selectTab(0);
  }



  double _getNumericalValue(WeaponModel w, String attribute) {
    switch (attribute) {
      case 'Dano':
        return double.tryParse(w.damage) ?? 0.0;
      case 'Velocidade':
        return double.tryParse(w.speed.split(' ')[0]) ?? 0.0;
      case 'BDMG2':
        return w.bodyDamageLevel2;
      case 'PWR':
        return w.powerValue;
      default:
        return 0.0;
    }
  }

  List<String> _getWinnersForAttribute(String attribute) {
    if (selectedWeapons.length < 2) return [];

    double maxVal = selectedWeapons.fold(0.0, (max, w) {
      double val = _getNumericalValue(w, attribute);
      return (val > max) ? val : max;
    });

    return selectedWeapons
        .where((w) => _getNumericalValue(w, attribute) == maxVal)
        .map((w) => w.id)
        .toList();
  }

  List<ComparisonPlatformViewModel> get platformViewModels {
    final List<ComparisonPlatformViewModel> viewModels = [];

    // Slot 1
    if (selectedWeapons.isNotEmpty) {
      viewModels.add(ComparisonPlatformViewModel(imagePath: selectedWeapons[0].imagePath, size: 140.0));
    } else {
      viewModels.add(ComparisonPlatformViewModel(imagePath: '', size: 140.0));
    }

    // Slot 2
    if (selectedWeapons.length > 1) {
      viewModels.add(ComparisonPlatformViewModel(imagePath: selectedWeapons[1].imagePath, size: 140.0));
    } else {
      viewModels.add(ComparisonPlatformViewModel(imagePath: '', size: 140.0));
    }
    return viewModels;
  }

  ValueComparisonViewModel buildComparisonCard(String attribute, String unit, {ComparisonContext? context}) {
    String realAttribute = attribute;
    if (context == ComparisonContext.shortRangeTTK) realAttribute = 'BDMG2';
    if (context == ComparisonContext.powerComparison) realAttribute = 'PWR';

    final winners = _getWinnersForAttribute(realAttribute);

    final entry1 = selectedWeapons.isNotEmpty ? selectedWeapons[0] : null;
    final entry2 = selectedWeapons.length > 1 ? selectedWeapons[1] : null;

    Color getColor(WeaponModel? entry) {
      if (entry == null) return Colors.grey;
      if (winners.isEmpty) return Colors.white;
      return winners.contains(entry.id) ? const Color(0xFF4CAF50) : const Color(0xFFF44336);
    }

    String getDisplayValue(WeaponModel? entry) {
      if (entry == null) return '-';
      double val = _getNumericalValue(entry, realAttribute);
      String formatted = val % 1 == 0 ? val.toInt().toString() : val.toStringAsFixed(1);
      return unit.isEmpty ? formatted : "$formatted $unit";
    }

    String getSectionTitle() {
      switch (context) {
        case ComparisonContext.rawDamage: return 'DANO BASE (BDMG 0)';
        case ComparisonContext.shortRangeTTK: return 'DANO CORPO (NV2)';
        case ComparisonContext.longRangeAccuracy: return 'VELOCIDADE (SPD)';
        case ComparisonContext.powerComparison: return 'POTÊNCIA (PWR)';
        default: return attribute.toUpperCase();
      }
    }

    return ValueComparisonViewModel(
      entry1: ValueEntry(
        value: getDisplayValue(entry1),
        label: entry1?.name ?? '-',
        color: getColor(entry1),
      ),
      entry2: ValueEntry(
        value: getDisplayValue(entry2),
        label: entry2?.name ?? '-',
        color: getColor(entry2),
      ),
      details: [getSectionTitle()],
      theme: ValueCardTheme.dark,
    );
  }
}