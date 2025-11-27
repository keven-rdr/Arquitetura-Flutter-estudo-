import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../DesignSystem/Components/Card/app_card.dart';
import '../../resources/shared/colors.dart';
import 'favorites_view_model.dart';

class FavoritesPage extends StatefulWidget {
  final FavoritesViewModel viewModel;
  const FavoritesPage({super.key, required this.viewModel});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        final cards = widget.viewModel.cards;

        return Scaffold(
          backgroundColor: dividerColorLight,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          body: cards.isEmpty
              ? _buildEmptyState()
              : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: cards.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              return AppCard(viewModel: cards[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.heart, size: 64, color: Colors.white.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text(
            "Você ainda não tem favoritos",
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}