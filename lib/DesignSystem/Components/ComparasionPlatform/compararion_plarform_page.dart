import 'package:flutter/material.dart';
import '../../../resources/shared/colors.dart';
import 'comparasion_platform_view_model.dart';

class ComparisonPlatform extends StatelessWidget {
  final ComparisonPlatformViewModel viewModel;

  const ComparisonPlatform({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final bool hasImage = viewModel.imagePath.isNotEmpty && !viewModel.imagePath.contains('empty');

    return Container(
      width: viewModel.size,
      height: viewModel.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: hasImage ? RadialGradient(
          colors: [
            brandSecondary.withOpacity(0.3),
            Colors.black.withOpacity(0.8),
          ],
          radius: 0.8,
        ) : null,
        color: hasImage ? null : Colors.white10,
        border: hasImage ? Border.all(color: brandSecondary.withOpacity(0.5), width: 1) : null,
      ),
      child: Center(
        child: viewModel.imagePath.isNotEmpty
            ? Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            viewModel.imagePath,
            fit: BoxFit.contain,
          ),
        )
            : const Icon(Icons.add, color: Colors.white24, size: 40),
      ),
    );
  }
}