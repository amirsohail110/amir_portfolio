import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive_util.dart';
import '../../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../domain/entities/experience.dart';
import '../../bloc/portfolio_bloc.dart';
import '../../bloc/portfolio_state.dart';

/// Career as an editorial timeline — period rail on the left, narrative card
/// on the right, connected by a single vertical line.
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      alt: true,
      child: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          final experiences =
              state is PortfolioLoaded ? state.experiences : <Experience>[];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                eyebrow: 'THE TRACK RECORD',
                title: 'Four years, one consistent thread: systems under load.',
                maxTitleWidth: 760,
              ),
              const SizedBox(height: 64),
              for (var i = 0; i < experiences.length; i++)
                RevealOnScroll(
                  delay: Duration(milliseconds: 80 * i),
                  child: _TimelineEntry(
                    experience: experiences[i],
                    isLast: i == experiences.length - 1,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({required this.experience, required this.isLast});

  final Experience experience;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveUtil.isMobile(context);

    final card = _Card(experience: experience, isDark: isDark);

    if (isMobile) {
      return Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _periodPill(isDark),
            const SizedBox(height: 14),
            card,
          ],
        ),
      );
    }

    // The rail line is the left border of the entry wrapper, so it tracks the
    // entry's natural height (no IntrinsicHeight/stretch — both need a bounded
    // height and throw inside the scroll view's unbounded Column). The node dot
    // is overlaid on the border with a Positioned offset.
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Padding(
            padding: const EdgeInsets.only(top: 2, right: 24),
            child: _periodPill(isDark),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 32, bottom: isLast ? 0 : 40),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: AppColors.border(isDark), width: 1.5),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(left: -39, top: 4, child: _dot(isDark)),
                card,
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _dot(bool isDark) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: experience.isCurrent
            ? AppColors.gold(isDark)
            : AppColors.backgroundSecondary(isDark),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.gold(isDark), width: 2),
      ),
    );
  }

  Widget _periodPill(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(experience.period,
            style: AppTextStyles.mono.copyWith(
              color: AppColors.textSecondary(isDark),
              fontSize: 12,
            )),
        if (experience.isCurrent) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text('CURRENT',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.success,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                )),
          ),
        ],
      ],
    );
  }

}

class _Card extends StatelessWidget {
  const _Card({required this.experience, required this.isDark});
  final Experience experience;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.card(isDark),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border(isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(experience.role,
              style: AppTextStyles.headlineSmall
                  .copyWith(color: AppColors.textPrimary(isDark))),
          const SizedBox(height: 4),
          Text(experience.company,
              style: AppTextStyles.titleMedium
                  .copyWith(color: AppColors.gold(isDark))),
          const SizedBox(height: 16),
          Text(experience.description,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary(isDark))),
          const SizedBox(height: 20),
          ...experience.highlights.map((h) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6, right: 12),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.gold(isDark),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(h,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary(isDark),
                            height: 1.5,
                          )),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: experience.techStack
                .map((t) => _TechTag(label: t, isDark: isDark))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  const _TechTag({required this.label, required this.isDark});
  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface(isDark),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.borderSubtle(isDark)),
      ),
      child: Text(label,
          style: AppTextStyles.mono.copyWith(
            color: AppColors.textSecondary(isDark),
            fontSize: 12,
          )),
    );
  }
}
