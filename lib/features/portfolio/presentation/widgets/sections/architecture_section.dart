import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive_util.dart';
import '../../../../../core/widgets/reveal_on_scroll.dart';
import '../../../../../core/widgets/section_container.dart';
import '../../content/site_content.dart';

/// "How I think about software" — the architecture philosophy plus a literal
/// trace of a real-time price from the exchange to a sub-16ms render.
class ArchitectureSection extends StatelessWidget {
  const ArchitectureSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      alt: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            eyebrow: 'HOW I THINK ABOUT SOFTWARE',
            title: 'Architecture is what keeps you fast for years.',
            intro:
                'Patterns aren\'t decoration. Each choice below exists to protect '
                'one of two things: correctness when money moves, or velocity as '
                'the system grows.',
            maxTitleWidth: 760,
          ),
          const SizedBox(height: 56),
          const RevealOnScroll(child: _DataFlowPanel()),
          const SizedBox(height: 48),
          const _PrinciplesGrid(),
        ],
      ),
    );
  }
}

// ── Data-flow diagram ─────────────────────────────────────────────────────────

class _DataFlowPanel extends StatelessWidget {
  const _DataFlowPanel();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDesktop = ResponsiveUtil.isDesktop(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isDesktop ? 36 : 22),
      decoration: BoxDecoration(
        color: AppColors.card(isDark),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border(isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, size: 18, color: AppColors.gold(isDark)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'One live price, end to end',
                  style: AppTextStyles.titleMedium
                      .copyWith(color: AppColors.textPrimary(isDark)),
                ),
              ),
              Text('< 100ms',
                  style: AppTextStyles.mono.copyWith(
                    color: AppColors.gold(isDark),
                    fontWeight: FontWeight.w700,
                  )),
            ],
          ),
          const SizedBox(height: 28),
          isDesktop ? _horizontalFlow(isDark) : _verticalFlow(isDark),
        ],
      ),
    );
  }

  Widget _horizontalFlow(bool isDark) {
    final nodes = kDataFlow;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < nodes.length; i++) ...[
          Expanded(child: _FlowNodeTile(node: nodes[i], isDark: isDark)),
          if (i < nodes.length - 1)
            Padding(
              padding: const EdgeInsets.only(top: 26),
              child: Icon(Icons.arrow_forward,
                  size: 18, color: AppColors.copperAccent(isDark)),
            ),
        ],
      ],
    );
  }

  Widget _verticalFlow(bool isDark) {
    final nodes = kDataFlow;
    return Column(
      children: [
        for (var i = 0; i < nodes.length; i++) ...[
          _FlowNodeTile(node: nodes[i], isDark: isDark, horizontal: true),
          if (i < nodes.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Icon(Icons.arrow_downward,
                  size: 18, color: AppColors.copperAccent(isDark)),
            ),
        ],
      ],
    );
  }
}

class _FlowNodeTile extends StatelessWidget {
  const _FlowNodeTile({
    required this.node,
    required this.isDark,
    this.horizontal = false,
  });
  final FlowNode node;
  final bool isDark;
  final bool horizontal;

  @override
  Widget build(BuildContext context) {
    final icon = Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.gold(isDark).withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: AppColors.gold(isDark).withValues(alpha: 0.4)),
      ),
      child: Icon(node.icon, size: 22, color: AppColors.gold(isDark)),
    );

    final texts = Column(
      crossAxisAlignment:
          horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(node.label,
            textAlign: horizontal ? TextAlign.start : TextAlign.center,
            style: AppTextStyles.titleSmall
                .copyWith(color: AppColors.textPrimary(isDark))),
        const SizedBox(height: 3),
        Text(node.sub,
            textAlign: horizontal ? TextAlign.start : TextAlign.center,
            style: AppTextStyles.labelSmall
                .copyWith(color: AppColors.textMuted(isDark))),
      ],
    );

    if (horizontal) {
      return Row(
        children: [
          icon,
          const SizedBox(width: 14),
          Expanded(child: texts),
        ],
      );
    }
    return Column(
      children: [
        icon,
        const SizedBox(height: 12),
        texts,
      ],
    );
  }
}

// ── Principles grid ───────────────────────────────────────────────────────────

class _PrinciplesGrid extends StatelessWidget {
  const _PrinciplesGrid();

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
          for (var i = 0; i < kArchPrinciples.length; i++)
            SizedBox(
              width: cardWidth,
              child: RevealOnScroll(
                delay: Duration(milliseconds: 70 * i),
                child: _PrincipleCard(principle: kArchPrinciples[i]),
              ),
            ),
        ],
      );
    });
  }
}

class _PrincipleCard extends StatefulWidget {
  const _PrincipleCard({required this.principle});
  final ArchPrinciple principle;

  @override
  State<_PrincipleCard> createState() => _PrincipleCardState();
}

class _PrincipleCardState extends State<_PrincipleCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final p = widget.principle;
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: 248,
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: AppColors.background(isDark),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hover ? AppColors.gold(isDark) : AppColors.border(isDark),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.index,
                style: AppTextStyles.mono.copyWith(
                  color: AppColors.gold(isDark),
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                )),
            const SizedBox(height: 16),
            Text(p.title,
                style: AppTextStyles.titleLarge
                    .copyWith(color: AppColors.textPrimary(isDark))),
            const SizedBox(height: 10),
            Expanded(
              child: Text(p.body,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary(isDark),
                    height: 1.55,
                  )),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: p.tags
                  .map((t) => Text('· $t',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.copperAccent(isDark),
                      )))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
