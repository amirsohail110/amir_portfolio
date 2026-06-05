import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'animated_text_slide_box_transition.dart';

/// Theme-aware section heading with optional slide-box reveal animation.
///
/// When [controller] is provided the title is rendered through
/// [AnimatedTextSlideBoxTransition]. When null the title is rendered
/// statically so it can be used without an animation controller.
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    this.centerAlign = false,
    this.animate = false,
    this.controller,
  });

  final String tag;
  final String title;
  final String? subtitle;
  final bool centerAlign;

  /// Kept for backwards compatibility — when true and [controller] is null,
  /// the widget still renders without animation (no FadeInUp dependency).
  final bool animate;

  /// When provided, the title uses AnimatedTextSlideBoxTransition.
  final AnimationController? controller;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment:
          centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTag(isDark),
        const SizedBox(height: 12),
        _buildTitle(context, isDark),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          _buildSubtitle(isDark),
        ],
        const SizedBox(height: 16),
        _buildAccentLine(centerAlign),
      ],
    );
  }

  Widget _buildTag(bool isDark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 24, height: 2, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          tag.toUpperCase(),
          style: AppTextStyles.sectionTag,
        ),
        const SizedBox(width: 8),
        Container(width: 24, height: 2, color: AppColors.primary),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, bool isDark) {
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    // The gradient ShaderMask looks great in both themes.
    // When animating we wrap inside ShaderMask after the slide-box reveals.
    if (controller != null) {
      return ShaderMask(
        shaderCallback: (bounds) =>
            AppColors.primaryGradient.createShader(bounds),
        blendMode: BlendMode.srcIn,
        child: AnimatedTextSlideBoxTransition(
          controller: controller!,
          text: title,
          textStyle: AppTextStyles.displaySmall.copyWith(
            color: AppColors.primary, // colour overridden by ShaderMask
          ),
          boxColor: bgColor,
          coverColor: Colors.transparent,
          maxLines: 3,
          textAlign: centerAlign ? TextAlign.center : TextAlign.start,
        ),
      );
    }

    return ShaderMask(
      shaderCallback: (bounds) =>
          AppColors.primaryGradient.createShader(bounds),
      blendMode: BlendMode.srcIn,
      child: Text(
        title,
        style: AppTextStyles.displaySmall,
        textAlign: centerAlign ? TextAlign.center : TextAlign.start,
      ),
    );
  }

  Widget _buildSubtitle(bool isDark) {
    return Text(
      subtitle!,
      style: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textSecondary(isDark),
      ),
      textAlign: centerAlign ? TextAlign.center : TextAlign.start,
    );
  }

  Widget _buildAccentLine(bool centerAlign) {
    final line = Container(
      width: 60,
      height: 4,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGlow,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
    );

    if (centerAlign) return Center(child: line);
    return line;
  }
}
