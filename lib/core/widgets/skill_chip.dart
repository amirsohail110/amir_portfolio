import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SkillChip extends StatefulWidget {
  const SkillChip({
    super.key,
    required this.label,
    this.isHighlighted = false,
    this.delay = 0,
  });

  final String label;
  final bool isHighlighted;
  final int delay;

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isActive = _isHovered || widget.isHighlighted;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primarySoft : AppColors.surface(isDark),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? AppColors.primary : AppColors.border(isDark),
            width: 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.primaryGlow,
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.label,
          style: AppTextStyles.labelMedium.copyWith(
            color: isActive
                ? AppColors.primary
                : AppColors.textSecondary(isDark),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
