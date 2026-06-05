import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

enum PremiumButtonVariant { solid, outline, ghost }

/// Restrained, warm CTA. Solid = gold fill with ink label; outline = hairline
/// border that fills with sand on hover; ghost = text + arrow nudge. No glow.
class PremiumButton extends StatefulWidget {
  const PremiumButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
    this.trailingIcon,
    this.variant = PremiumButtonVariant.solid,
    this.height = 54,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final IconData? trailingIcon;
  final PremiumButtonVariant variant;
  final double height;

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gold = AppColors.gold(isDark);
    final ink = AppColors.textPrimary(isDark);

    late final Color bg;
    late final Color fg;
    late final Border? border;

    switch (widget.variant) {
      case PremiumButtonVariant.solid:
        bg = _hover ? AppColors.copperAccent(isDark) : gold;
        fg = isDark ? AppColors.darkBackground : Colors.white;
        border = null;
        break;
      case PremiumButtonVariant.outline:
        bg = _hover ? AppColors.surface(isDark) : Colors.transparent;
        fg = ink;
        border = Border.all(
          color: _hover ? gold : AppColors.border(isDark),
          width: 1.2,
        );
        break;
      case PremiumButtonVariant.ghost:
        bg = Colors.transparent;
        fg = _hover ? gold : ink;
        border = null;
        break;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          height: widget.height,
          padding: EdgeInsets.symmetric(
              horizontal: widget.variant == PremiumButtonVariant.ghost ? 4 : 26),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(100),
            border: border,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: fg),
                const SizedBox(width: 10),
              ],
              Text(
                widget.label,
                style: AppTextStyles.labelLarge
                    .copyWith(color: fg, fontWeight: FontWeight.w600),
              ),
              if (widget.trailingIcon != null) ...[
                AnimatedSlide(
                  duration: const Duration(milliseconds: 220),
                  offset: _hover ? const Offset(0.18, 0) : Offset.zero,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(widget.trailingIcon, size: 18, color: fg),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
