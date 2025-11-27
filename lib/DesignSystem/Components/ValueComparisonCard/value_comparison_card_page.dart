import 'package:flutter/material.dart';
import '../../../resources/shared/colors.dart';
import 'value_comparison_card_view_model.dart';

class ValueComparisonCard extends StatelessWidget {
  final ValueComparisonViewModel viewModel;

  const ValueComparisonCard({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final bool isDark = viewModel.theme == ValueCardTheme.dark;
    final Color cardColor = isDark ? const Color(0xFF1E1E1E) : neutralLight;
    final Color dividerColor = isDark ? Colors.grey[700]! : Colors.grey[300]!;
    final Color detailsColor = isDark ? Colors.grey[400]! : Colors.grey[600]!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _buildValueColumn(
                  viewModel.entry1,
                  CrossAxisAlignment.end,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 40,
                  width: 1,
                  color: dividerColor,
                ),
              ),
              Expanded(
                child: _buildValueColumn(
                  viewModel.entry2,
                  CrossAxisAlignment.start,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (viewModel.details.isNotEmpty)
            Text(
              viewModel.details.first.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: detailsColor,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
        ],
      ),
    );
  }
  Widget _buildValueColumn(ValueEntry entry, CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            entry.value,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: entry.color,
              height: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          entry.label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}