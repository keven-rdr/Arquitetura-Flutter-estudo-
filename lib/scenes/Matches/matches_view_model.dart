import 'package:flutter/material.dart';
import '../../DesignSystem/Components/ComparasionPlatform/comparasion_platform_view_model.dart';
import '../../DesignSystem/Components/ValueComparisonCard/value_comparison_card_view_model.dart';
import '../../resources/models/weapon_model.dart';
import '../../resources/services/comparison_service.dart';

class MatchesViewModel extends ChangeNotifier {
  final ComparisonService _comparisonService;

  MatchesViewModel({required ComparisonService comparisonService})
      : _comparisonService = comparisonService {
    _comparisonService.addListener(notifyListeners);
  }

  List<WeaponModel> get selectedWeapons => _comparisonService.selectedWeapons;
  int get limit => _comparisonService.maxComparisonLimit;

  @override
  void dispose() {
    _comparisonService.removeListener(notifyListeners);
    super.dispose();
  }

  void removeWeapon(String id) {
    _comparisonService.removeWeapon(id);
  }

  List<ComparisonPlatformViewModel> get platformViewModels {
    return selectedWeapons.map((w) => ComparisonPlatformViewModel(
      imagePath: w.imagePath,
      size: 100.0,
    )).toList();
  }

  ValueComparisonViewModel buildComparisonCard(String attribute, String unit) {
    final winners = _comparisonService.getWinners(attribute);
    final detailsList = selectedWeapons.map((w) => "${w.name}: ${w.damage}").toList();

    final entry1 = selectedWeapons.isNotEmpty ? selectedWeapons[0] : null;
    final entry2 = selectedWeapons.length > 1 ? selectedWeapons[1] : null;

    Color getColor(WeaponModel? entry) {
      if (entry == null) return Colors.grey;
      return winners.contains(entry.id) ? Colors.green : Colors.red;
    }

    return ValueComparisonViewModel(
      entry1: ValueEntry(
        value: entry1?.damage ?? '-',
        label: entry1?.name ?? 'Slot 1',
        color: getColor(entry1),
      ),
      entry2: ValueEntry(
        value: entry2?.damage ?? '-',
        label: entry2?.name ?? 'Slot 2',
        color: getColor(entry2),
      ),
      details: ['Comparando atributos de $attribute ($unit)'],
      theme: ValueCardTheme.dark,
    );
  }
}