import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../DesignSystem/Components/ComparasionPlatform/compararion_plarform_page.dart';
import '../../DesignSystem/Components/ComparasionPlatform/comparasion_platform_view_model.dart';
import '../../DesignSystem/Components/ValueComparisonCard/value_comparison_card_page.dart';
import '../../resources/shared/colors.dart';
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
          final canCompare = widget.viewModel.canCompare;

          return Scaffold(
            backgroundColor: const Color(0xFF121212),
            appBar: AppBar(
              title: const Text("Comparação", style: TextStyle(fontWeight: FontWeight.bold)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(LucideIcons.chevronLeft),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),

                    // 1. Plataformas de Comparação (Sempre visíveis)
                    _buildComparisonRow(weapons),

                    const SizedBox(height: 40),

                    // 2. Lógica de Exibição Condicional
                    // Se puder comparar, mostra os cards. Se não, mostra mensagem vazia.
                    if (canCompare)
                      ..._buildDataCards()
                    else
                      _buildEmptyStateMessage(),

                    const SizedBox(height: 32),

                    // 3. Botão de Adicionar (Só aparece se houver espaço livre)
                    if (weapons.length < widget.viewModel.limit)
                      OutlinedButton.icon(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(LucideIcons.plus, color: brandPrimary),
                        label: const Text("ADICIONAR ARMA", style: TextStyle(color: brandPrimary, fontWeight: FontWeight.bold)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: brandPrimary),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                  ],
                )
            ),
          );
        }
    );
  }

  // --- Widgets Auxiliares ---

  Widget _buildEmptyStateMessage() {
    return Column(
      children: [
        Icon(LucideIcons.barChart2, size: 60, color: Colors.white.withOpacity(0.1)),
        const SizedBox(height: 16),
        Text(
          "Selecione 2 armas para ver os dados",
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildDataCards() {
    return [
      ValueComparisonCard(
        viewModel: widget.viewModel.buildComparisonCard('Dano', '', context: ComparisonContext.rawDamage),
      ),
      const SizedBox(height: 12),
      ValueComparisonCard(
        viewModel: widget.viewModel.buildComparisonCard('BDMG2', '', context: ComparisonContext.shortRangeTTK),
      ),
      const SizedBox(height: 12),
      ValueComparisonCard(
        viewModel: widget.viewModel.buildComparisonCard('Velocidade', 'm/s', context: ComparisonContext.longRangeAccuracy),
      ),
      const SizedBox(height: 12),
      ValueComparisonCard(
        viewModel: widget.viewModel.buildComparisonCard('PWR', '', context: ComparisonContext.powerComparison),
      ),
    ];
  }

  Widget _buildComparisonRow(List<WeaponModel> weapons) {
    // Garante o acesso seguro aos slots (evita erro de índice)
    final vm1 = widget.viewModel.platformViewModels[0];
    final vm2 = widget.viewModel.platformViewModels[1];

    final w1 = weapons.isNotEmpty ? weapons[0] : null;
    final w2 = weapons.length > 1 ? weapons[1] : null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildSlotColumn(vm1, w1),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              border: Border.all(color: brandPrimary, width: 2),
              boxShadow: [
                BoxShadow(color: brandPrimary.withOpacity(0.4), blurRadius: 10)
              ]
          ),
          child: const Center(
            child: Text('VS', style: TextStyle(color: brandPrimary, fontWeight: FontWeight.w900, fontSize: 20, fontStyle: FontStyle.italic)),
          ),
        ),
        _buildSlotColumn(vm2, w2),
      ],
    );
  }

  Widget _buildSlotColumn(ComparisonPlatformViewModel vm, WeaponModel? weapon) {
    return Column(
      children: [
        ComparisonPlatform(viewModel: vm),
        const SizedBox(height: 8),
        if (weapon != null)
          GestureDetector(
            onTap: () => widget.viewModel.removeWeapon(weapon.id),
            child: Row(
              children: [
                const Icon(LucideIcons.x, size: 14, color: Colors.redAccent),
                const SizedBox(width: 4),
                Text("Remover", style: TextStyle(color: Colors.redAccent.withOpacity(0.8), fontSize: 12)),
              ],
            ),
          )
        else
          const SizedBox(height: 20), // Espaço vazio para manter alinhamento
      ],
    );
  }
}