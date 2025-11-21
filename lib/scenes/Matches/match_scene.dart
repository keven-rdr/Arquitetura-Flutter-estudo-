import '../../DesignSystem/Components/ComparasionPlatform/compararion_plarform_page.dart';
import '../../DesignSystem/Components/ComparasionPlatform/comparasion_platform_view_model.dart';
import '../../DesignSystem/Components/ValueComparisonCard/value_comparison_card_page.dart';
import 'package:arqmvvm/resources/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../resources/models/weapon_model.dart';
import 'matches_view_model.dart';

class MatchesPage extends StatefulWidget {
  final MatchesViewModel viewModel;
  const MatchesPage({super.key, required this.viewModel});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, child) {
          final weapons = widget.viewModel.selectedWeapons;
          final platforms = widget.viewModel.platformViewModels;

          return Scaffold(
            backgroundColor: dividerColorLight,
            appBar: AppBar(
              title: const Text("Comparação de Armas"),
              backgroundColor: brandSecondary,
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildComparisonPlatforms(platforms, weapons),

                    const SizedBox(height: 32),

                    ValueComparisonCard(
                      viewModel: widget.viewModel.buildComparisonCard('Dano', 'Dano Base'),
                    ),
                  ],
                )
            ),
          );
        }
    );
  }

  Widget _buildComparisonPlatforms(
      List<ComparisonPlatformViewModel> platforms,
      List<WeaponModel> weapons) {

    final emptySlots = List.generate(
      widget.viewModel.limit - platforms.length,
          (index) => ComparisonPlatformViewModel(imagePath: 'assets/placeholders/empty.png', size: 100),
    );

    final allPlatforms = [...platforms, ...emptySlots];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: allPlatforms.asMap().entries.map((entry) {
        final index = entry.key;
        final platformVM = entry.value;
        final weapon = index < weapons.length ? weapons[index] : null;

        return Column(
          children: [
            ComparisonPlatform(viewModel: platformVM),
            if (weapon != null)
              TextButton.icon(
                onPressed: () => widget.viewModel.removeWeapon(weapon.id),
                icon: const Icon(LucideIcons.x, size: 16, color: Colors.red),
                label: Text("Remover", style: TextStyle(color: Colors.red)),
              )
          ],
        );
      }).toList(),
    );
  }
}