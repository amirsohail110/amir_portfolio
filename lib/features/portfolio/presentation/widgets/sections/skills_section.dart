import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive_util.dart';
import '../../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../../domain/entities/skill_category.dart';
import '../../bloc/portfolio_bloc.dart';
import '../../bloc/portfolio_state.dart';

/// Capability map — grouped by what the skill is *for*, leading with the
/// real-time / architecture categories that define the positioning.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const Map<String, IconData> _icons = {
    'network': Icons.bolt_outlined,
    'architecture': Icons.account_tree_outlined,
    'mobile': Icons.smartphone_outlined,
    'backend': Icons.dns_outlined,
    'security': Icons.shield_outlined,
    'integrations': Icons.extension_outlined,
    'storage': Icons.storage_outlined,
    'devops': Icons.terminal_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: BlocBuilder<PortfolioBloc, PortfolioState>(
        builder: (context, state) {
          final categories = state is PortfolioLoaded
              ? state.skillCategories
              : <SkillCategory>[];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                eyebrow: 'CAPABILITIES',
                title: 'The toolkit behind the systems.',
                maxTitleWidth: 620,
              ),
              const SizedBox(height: 48),
              _Grid(categories: categories, icons: _icons),
            ],
          );
        },
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid({required this.categories, required this.icons});
  final List<SkillCategory> categories;
  final Map<String, IconData> icons;

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
          for (var i = 0; i < categories.length; i++)
            SizedBox(
              width: cardWidth,
              child: RevealOnScroll(
                delay: Duration(milliseconds: 60 * i),
                child: _CategoryCard(
                  category: categories[i],
                  icon: icons[categories[i].icon] ?? Icons.code,
                ),
              ),
            ),
        ],
      );
    });
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category, required this.icon});
  final SkillCategory category;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppColors.card(isDark),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border(isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.gold(isDark).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: AppColors.gold(isDark)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(category.name,
                    style: AppTextStyles.titleLarge
                        .copyWith(color: AppColors.textPrimary(isDark))),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category.skills
                .map((s) => _Tag(label: s, isDark: isDark))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.isDark});
  final String label;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.surface(isDark),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderSubtle(isDark)),
      ),
      child: Text(label,
          style: AppTextStyles.labelMedium
              .copyWith(color: AppColors.textSecondary(isDark))),
    );
  }
}
