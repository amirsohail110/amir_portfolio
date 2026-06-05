import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive_util.dart';
import '../../../../../core/utils/url_launcher_util.dart';
import '../../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../domain/entities/project.dart';
import '../../bloc/portfolio_bloc.dart';
import '../../bloc/portfolio_state.dart';

/// Signature work as case studies (problem → architecture → impact), followed
/// by a compact grid of selected craft / open-source projects.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          final projects =
              state is PortfolioLoaded ? state.projects : <Project>[];
          final caseStudies =
              projects.where((p) => p.isCaseStudy).toList();
          final minor = projects.where((p) => !p.isCaseStudy).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                eyebrow: 'SIGNATURE WORK',
                title: 'Case studies, not screenshots.',
                intro:
                    'Three systems that show how I work: the constraint I was '
                    'handed, the architecture I chose, and what it changed.',
              ),
              const SizedBox(height: 56),
              for (var i = 0; i < caseStudies.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                      bottom: i == caseStudies.length - 1 ? 0 : 32),
                  child: RevealOnScroll(
                    child: _CaseStudyCard(
                      project: caseStudies[i],
                      index: i + 1,
                    ),
                  ),
                ),
              if (minor.isNotEmpty) ...[
                const SizedBox(height: 72),
                RevealOnScroll(
                  child: Text(
                    'Selected craft & open source'.toUpperCase(),
                    style: AppTextStyles.sectionTag,
                  ),
                ),
                const SizedBox(height: 28),
                _MinorGrid(projects: minor),
              ],
            ],
          );
        },
      ),
    );
  }
}

// ── Case study card ───────────────────────────────────────────────────────────

class _CaseStudyCard extends StatefulWidget {
  const _CaseStudyCard({required this.project, required this.index});
  final Project project;
  final int index;

  @override
  State<_CaseStudyCard> createState() => _CaseStudyCardState();
}

class _CaseStudyCardState extends State<_CaseStudyCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = ResponsiveUtil.isDesktop(context);
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        padding: EdgeInsets.all(isDesktop ? 40 : 26),
        decoration: BoxDecoration(
          color: AppColors.card(isDark),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: _hover ? AppColors.gold(isDark) : AppColors.border(isDark),
          ),
          boxShadow: _hover
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
                    blurRadius: 36,
                    offset: const Offset(0, 16),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(isDark),
            const SizedBox(height: 28),
            if (p.metrics.isNotEmpty) ...[
              _metricsRow(isDark),
              const SizedBox(height: 32),
            ],
            isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _block(isDark, 'The problem', p.problem!),
                            const SizedBox(height: 24),
                            _block(isDark, 'The architecture', p.architecture!),
                          ],
                        ),
                      ),
                      const SizedBox(width: 48),
                      Expanded(flex: 2, child: _impact(isDark)),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _block(isDark, 'The problem', p.problem!),
                      const SizedBox(height: 24),
                      _block(isDark, 'The architecture', p.architecture!),
                      const SizedBox(height: 24),
                      _impact(isDark),
                    ],
                  ),
            const SizedBox(height: 28),
            Divider(height: 1, color: AppColors.border(isDark)),
            const SizedBox(height: 20),
            _footer(isDark),
          ],
        ),
      ),
    );
  }

  Widget _header(bool isDark) {
    final p = widget.project;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CASE STUDY 0${widget.index}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.gold(isDark),
                    letterSpacing: 2,
                  )),
              const SizedBox(height: 12),
              Text(p.title,
                  style: AppTextStyles.displaySmall.copyWith(
                    color: AppColors.textPrimary(isDark),
                    fontSize: ResponsiveUtil.isMobile(context) ? 28 : 36,
                  )),
              if (p.tagline != null) ...[
                const SizedBox(height: 8),
                Text(p.tagline!,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary(isDark),
                    )),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  if (p.role != null)
                    Text(p.role!,
                        style: AppTextStyles.labelMedium
                            .copyWith(color: AppColors.copperAccent(isDark))),
                  if (p.role != null && p.year != null)
                    Text('  ·  ',
                        style: AppTextStyles.labelMedium
                            .copyWith(color: AppColors.textMuted(isDark))),
                  if (p.year != null)
                    Text(p.year!,
                        style: AppTextStyles.labelMedium
                            .copyWith(color: AppColors.textMuted(isDark))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _metricsRow(bool isDark) {
    final metrics = widget.project.metrics;
    return Wrap(
      spacing: 14,
      runSpacing: 14,
      children: [
        for (final m in metrics)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary(isDark),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderSubtle(isDark)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m[0],
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.gold(isDark),
                    )),
                const SizedBox(height: 2),
                Text(m[1],
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textMuted(isDark),
                    )),
              ],
            ),
          ),
      ],
    );
  }

  Widget _block(bool isDark, String label, String body) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textMuted(isDark),
              letterSpacing: 1.6,
            )),
        const SizedBox(height: 10),
        Text(body,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary(isDark),
              height: 1.65,
            )),
      ],
    );
  }

  Widget _impact(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary(isDark),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderSubtle(isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('IMPACT',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.gold(isDark),
                letterSpacing: 2,
              )),
          const SizedBox(height: 14),
          ...widget.project.impact.map((line) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle_outline,
                        size: 16, color: AppColors.gold(isDark)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(line,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary(isDark),
                            height: 1.5,
                          )),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _footer(bool isDark) {
    final p = widget.project;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 12,
      children: [
        ...p.techStack.map((t) => _TechTag(label: t, isDark: isDark)),
        if (p.hasPlayStore || p.hasAppStore || p.hasGithub)
          const SizedBox(width: 8),
        if (p.hasPlayStore)
          _LinkChip(
            icon: FontAwesomeIcons.googlePlay,
            label: 'Play Store',
            onTap: () =>
                UrlLauncherUtil.launchURL(p.playStoreUrl!, context: context),
            isDark: isDark,
          ),
        if (p.hasAppStore)
          _LinkChip(
            icon: FontAwesomeIcons.appStoreIos,
            label: 'App Store',
            onTap: () =>
                UrlLauncherUtil.launchURL(p.appStoreUrl!, context: context),
            isDark: isDark,
          ),
        if (p.hasGithub)
          _LinkChip(
            icon: FontAwesomeIcons.github,
            label: 'Source',
            onTap: () =>
                UrlLauncherUtil.launchURL(p.githubUrl!, context: context),
            isDark: isDark,
          ),
      ],
    );
  }
}

// ── Minor projects grid ───────────────────────────────────────────────────────

class _MinorGrid extends StatelessWidget {
  const _MinorGrid({required this.projects});
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    final cols = ResponsiveUtil.responsive<int>(context,
        mobile: 1, tablet: 2, desktop: 3);
    const spacing = 20.0;

    return LayoutBuilder(builder: (context, c) {
      final cardWidth = (c.maxWidth - spacing * (cols - 1)) / cols;
      return Wrap(
        spacing: spacing,
        runSpacing: spacing,
        children: [
          for (var i = 0; i < projects.length; i++)
            SizedBox(
              width: cardWidth,
              child: RevealOnScroll(
                delay: Duration(milliseconds: 80 * i),
                child: _MinorCard(project: projects[i]),
              ),
            ),
        ],
      );
    });
  }
}

class _MinorCard extends StatefulWidget {
  const _MinorCard({required this.project});
  final Project project;

  @override
  State<_MinorCard> createState() => _MinorCardState();
}

class _MinorCardState extends State<_MinorCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final p = widget.project;
    return MouseRegion(
      cursor: p.hasGithub ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: p.hasGithub
            ? () => UrlLauncherUtil.launchURL(p.githubUrl!, context: context)
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.card(isDark),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hover ? AppColors.gold(isDark) : AppColors.border(isDark),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(p.title,
                        style: AppTextStyles.titleLarge.copyWith(
                          color: AppColors.textPrimary(isDark),
                        )),
                  ),
                  if (p.stars != null) ...[
                    Icon(Icons.star_border_rounded,
                        size: 16, color: AppColors.textMuted(isDark)),
                    const SizedBox(width: 3),
                    Text('${p.stars}',
                        style: AppTextStyles.mono.copyWith(
                          color: AppColors.textMuted(isDark),
                          fontSize: 12,
                        )),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(p.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary(isDark),
                  )),
              const SizedBox(height: 18),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: p.techStack
                    .take(4)
                    .map((t) => _TechTag(label: t, isDark: isDark))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Shared chips ──────────────────────────────────────────────────────────────

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

class _LinkChip extends StatefulWidget {
  const _LinkChip({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isDark,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDark;

  @override
  State<_LinkChip> createState() => _LinkChipState();
}

class _LinkChipState extends State<_LinkChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final gold = AppColors.gold(widget.isDark);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hover ? gold.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: _hover ? gold : AppColors.border(widget.isDark)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(widget.icon,
                  size: 13,
                  color: _hover ? gold : AppColors.textSecondary(widget.isDark)),
              const SizedBox(width: 8),
              Text(widget.label,
                  style: AppTextStyles.labelMedium.copyWith(
                    color:
                        _hover ? gold : AppColors.textSecondary(widget.isDark),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
