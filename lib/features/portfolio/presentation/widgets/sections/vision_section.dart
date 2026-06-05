import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive_util.dart';
import '../../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../../core/widgets/section_container.dart';

/// A short, confident statement of direction — the "where I'm headed" beat.
class VisionSection extends StatelessWidget {
  const VisionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveUtil.isMobile(context);

    return SectionContainer(
      child: RevealOnScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('“',
                style: AppTextStyles.displayLarge.copyWith(
                  color: AppColors.gold(isDark),
                  fontSize: 96,
                  height: 0.6,
                )),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(width: 28, height: 1.4, color: AppColors.gold(isDark)),
                const SizedBox(width: 12),
                Text(AppConstants.visionEyebrow,
                    style: AppTextStyles.sectionTag
                        .copyWith(color: AppColors.gold(isDark))),
              ],
            ),
            const SizedBox(height: 24),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Text(
                AppConstants.visionHeadline,
                style: (isMobile
                        ? AppTextStyles.headlineLarge
                        : AppTextStyles.displayMedium)
                    .copyWith(color: AppColors.textPrimary(isDark)),
              ),
            ),
            const SizedBox(height: 28),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                AppConstants.visionBody,
                style: AppTextStyles.bodyLarge
                    .copyWith(color: AppColors.textSecondary(isDark)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
