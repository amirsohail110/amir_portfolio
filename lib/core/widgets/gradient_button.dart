import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum GradientButtonVariant { filled, outlined, ghost }

class GradientButton extends StatefulWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.variant = GradientButtonVariant.filled,
    this.width,
    this.height = 52,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final GradientButtonVariant variant;
  final double? width;
  final double height;
  final bool isLoading;

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          height: widget.height,
          decoration: _buildDecoration(isDark),
          child: _buildContent(isDark),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration(bool isDark) {
    switch (widget.variant) {
      case GradientButtonVariant.filled:
        return BoxDecoration(
          gradient: _isHovered
              ? AppColors.accentGradient
              : AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryGlow,
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        );

      case GradientButtonVariant.outlined:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary
                : AppColors.border(isDark),
            width: 1.5,
          ),
          color: _isHovered ? AppColors.primarySoft : Colors.transparent,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primaryGlow,
                    blurRadius: 12,
                  ),
                ]
              : [],
        );

      case GradientButtonVariant.ghost:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _isHovered ? AppColors.primarySoft : Colors.transparent,
        );
    }
  }

  Widget _buildContent(bool isDark) {
    final Color textColor;
    if (widget.variant == GradientButtonVariant.filled) {
      // White text works on the gradient in both themes.
      textColor = Colors.white;
    } else {
      // outlined / ghost: primary colour works in both themes.
      textColor = AppColors.primary;
    }

    if (widget.isLoading) {
      return Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2, color: textColor),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[
            Icon(widget.icon, size: 18, color: textColor),
            const SizedBox(width: 8),
          ],
          Text(
            widget.label,
            style: AppTextStyles.labelLarge.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
