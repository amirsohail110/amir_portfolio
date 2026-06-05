import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../utils/responsive_util.dart';
import 'reveal_on_scroll.dart';

/// Consistent vertical rhythm + centred max-width column for every section.
/// [alt] paints the soft-sand background used to separate alternating sections.
class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.maxWidth = AppConstants.maxContentWidth,
    this.alt = false,
    this.topPadding,
    this.bottomPadding,
    this.id,
  });

  final Widget child;
  final double maxWidth;
  final bool alt;
  final double? topPadding;
  final double? bottomPadding;
  final Key? id;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final horizontal = ResponsiveUtil.horizontalPadding(context);
    final vertical = ResponsiveUtil.isMobile(context)
        ? 72.0
        : AppConstants.sectionPaddingVertical;

    return Container(
      key: id,
      width: double.infinity,
      color: alt ? AppColors.backgroundSecondary(isDark) : null,
      padding: EdgeInsets.only(
        left: horizontal,
        right: horizontal,
        top: topPadding ?? vertical,
        bottom: bottomPadding ?? vertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}

/// Tracked gold eyebrow with a short rule — the section's "kicker".
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.center = false});
  final String text;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(width: 28, height: 1.4, color: AppColors.gold(isDark)),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            text.toUpperCase(),
            style: AppTextStyles.sectionTag
                .copyWith(color: AppColors.gold(isDark)),
          ),
        ),
      ],
    );
  }
}

/// Eyebrow + serif heading + optional intro paragraph.
class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    this.intro,
    this.center = false,
    this.maxTitleWidth,
  });

  final String eyebrow;
  final String title;
  final String? intro;
  final bool center;
  final double? maxTitleWidth;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveUtil.isMobile(context);
    final align = center ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = center ? TextAlign.center : TextAlign.start;

    Widget titleWidget = Text(
      title,
      textAlign: textAlign,
      style: (isMobile
              ? AppTextStyles.headlineLarge
              : AppTextStyles.displaySmall)
          .copyWith(color: AppColors.textPrimary(isDark)),
    );
    if (maxTitleWidth != null) {
      titleWidget = ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxTitleWidth!),
        child: titleWidget,
      );
    }

    return RevealOnScroll(
      child: Column(
        crossAxisAlignment: align,
        mainAxisSize: MainAxisSize.min,
        children: [
          Eyebrow(eyebrow, center: center),
          const SizedBox(height: 20),
          titleWidget,
          if (intro != null) ...[
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Text(
                intro!,
                textAlign: textAlign,
                style: AppTextStyles.bodyLarge
                    .copyWith(color: AppColors.textSecondary(isDark)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
