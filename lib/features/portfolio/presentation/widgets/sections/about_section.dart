import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive_util.dart';
import '../../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../content/site_content.dart';

/// The career story — turns the résumé into a narrative the reader invests in.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtil.isDesktop(context);

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            eyebrow: AppConstants.storyEyebrow,
            title: AppConstants.storyHeadline,
            intro:
                'Most engineers describe what they can build. I care more about '
                'why it has to be built well — because in fintech, the cost of '
                '"good enough" is someone else\'s money.',
            maxTitleWidth: 720,
          ),
          const SizedBox(height: 64),
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(width: 320, child: _ProfileCard()),
                    SizedBox(width: 72),
                    Expanded(child: _StoryChapters()),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _ProfileCard(),
                    SizedBox(height: 48),
                    _StoryChapters(),
                  ],
                ),
          const SizedBox(height: 72),
          const _LeadershipRow(),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final facts = <List<String>>[
      ['Based in', AppConstants.location],
      ['Experience', '4+ years in production fintech'],
      ['Stack', 'Flutter · Dart · .NET'],
      ['Focus', 'Real-time & payments systems'],
    ];

    return RevealOnScroll(
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.card(isDark),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border(isDark)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(18),
              ),
              alignment: Alignment.center,
              child: Text(
                AppConstants.nameInitials,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 22),
            Text(AppConstants.name,
                style: AppTextStyles.headlineSmall
                    .copyWith(color: AppColors.textPrimary(isDark))),
            const SizedBox(height: 4),
            Text(AppConstants.title,
                style: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.gold(isDark))),
            const SizedBox(height: 24),
            Divider(height: 1, color: AppColors.border(isDark)),
            const SizedBox(height: 20),
            ...facts.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f[0].toUpperCase(),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textMuted(isDark),
                            letterSpacing: 1.4,
                          )),
                      const SizedBox(height: 3),
                      Text(f[1],
                          style: AppTextStyles.titleSmall.copyWith(
                            color: AppColors.textPrimary(isDark),
                          )),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _StoryChapters extends StatelessWidget {
  const _StoryChapters();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < kCareerStory.length; i++)
          RevealOnScroll(
            delay: Duration(milliseconds: 120 * i),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: i == kCareerStory.length - 1 ? 0 : 44),
              child: _Chapter(
                chapter: kCareerStory[i],
                index: i + 1,
                isLast: i == kCareerStory.length - 1,
                isDark: isDark,
              ),
            ),
          ),
      ],
    );
  }
}

class _Chapter extends StatelessWidget {
  const _Chapter({
    required this.chapter,
    required this.index,
    required this.isLast,
    required this.isDark,
  });

  final StoryChapter chapter;
  final int index;
  final bool isLast;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    // The vertical rule is the content's left border, so its height tracks the
    // content naturally — no IntrinsicHeight/stretch (both need a bounded height
    // and throw inside an unbounded scrolling Column).
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 46,
          child: Text('0$index',
              style: AppTextStyles.mono.copyWith(
                color: AppColors.gold(isDark),
                fontWeight: FontWeight.w700,
                fontSize: 15,
              )),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: AppColors.border(isDark), width: 1),
              ),
            ),
            padding: const EdgeInsets.only(left: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chapter.kicker.toUpperCase(),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.copperAccent(isDark),
                      letterSpacing: 1.6,
                    )),
                const SizedBox(height: 10),
                Text(chapter.title,
                    style: AppTextStyles.headlineMedium
                        .copyWith(color: AppColors.textPrimary(isDark))),
                const SizedBox(height: 14),
                Text(chapter.body,
                    style: AppTextStyles.bodyLarge
                        .copyWith(color: AppColors.textSecondary(isDark))),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LeadershipRow extends StatelessWidget {
  const _LeadershipRow();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveUtil.isMobile(context);

    final cards = [
      for (var i = 0; i < kLeadership.length; i++)
        RevealOnScroll(
          delay: Duration(milliseconds: 100 * i),
          child: _LeadCard(point: kLeadership[i], isDark: isDark),
        ),
    ];

    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: isMobile
          ? Column(
              children: [
                for (final c in cards)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: c,
                  ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < cards.length; i++) ...[
                  Expanded(child: cards[i]),
                  if (i < cards.length - 1) const SizedBox(width: 20),
                ],
              ],
            ),
    );
  }
}

class _LeadCard extends StatelessWidget {
  const _LeadCard({required this.point, required this.isDark});
  final LeadPoint point;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary(isDark),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border(isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(point.icon, size: 24, color: AppColors.gold(isDark)),
          const SizedBox(height: 18),
          Text(point.title,
              style: AppTextStyles.titleLarge
                  .copyWith(color: AppColors.textPrimary(isDark))),
          const SizedBox(height: 8),
          Text(point.body,
              style: AppTextStyles.bodyMedium
                  .copyWith(color: AppColors.textSecondary(isDark))),
        ],
      ),
    );
  }
}
