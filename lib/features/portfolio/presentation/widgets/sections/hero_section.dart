import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/responsive_util.dart';
import '../../../../../core/widgets/premium_button.dart';
import '../../../../../core/widgets/reveal_on_scroll.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    this.onPrimaryCta,
    this.onSecondaryCta,
  });

  final VoidCallback? onPrimaryCta;
  final VoidCallback? onSecondaryCta;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveUtil.isMobile(context);
    final isDesktop = ResponsiveUtil.isDesktop(context);
    final screenH = ResponsiveUtil.screenHeight(context);
    final horizontal = ResponsiveUtil.horizontalPadding(context);

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: _HeroCopy(
                      onPrimaryCta: onPrimaryCta,
                      onSecondaryCta: onSecondaryCta,
                    ),
                  ),
                  const SizedBox(width: 64),
                  const Expanded(flex: 5, child: LiveSystemCard()),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroCopy(
                    onPrimaryCta: onPrimaryCta,
                    onSecondaryCta: onSecondaryCta,
                  ),
                  const SizedBox(height: 48),
                  const LiveSystemCard(),
                ],
              ),
        SizedBox(height: isMobile ? 56 : 80),
        const _MetricsStrip(),
        const SizedBox(height: 40),
        const _TrustStrip(),
      ],
    );

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isMobile ? 0 : math.max(screenH, 640),
      ),
      decoration: BoxDecoration(
        gradient: AppColors.backgroundGradient(isDark),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(painter: _HeroBackdropPainter(isDark: isDark)),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              horizontal,
              isMobile ? 120 : 150,
              horizontal,
              isMobile ? 72 : 100,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: AppConstants.maxContentWidth),
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero copy block ───────────────────────────────────────────────────────────

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({this.onPrimaryCta, this.onSecondaryCta});
  final VoidCallback? onPrimaryCta;
  final VoidCallback? onSecondaryCta;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveUtil.isMobile(context);
    final headlineStyle = (isMobile
            ? AppTextStyles.displaySmall
            : AppTextStyles.displayLarge)
        .copyWith(color: AppColors.textPrimary(isDark));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RevealOnScroll(child: const _AvailabilityPill()),
        const SizedBox(height: 28),
        RevealOnScroll(
          delay: const Duration(milliseconds: 80),
          child: Text(AppConstants.heroEyebrow,
              style: AppTextStyles.sectionTag
                  .copyWith(color: AppColors.gold(isDark))),
        ),
        const SizedBox(height: 22),
        RevealOnScroll(
          delay: const Duration(milliseconds: 140),
          child: RichText(
            text: TextSpan(
              text: '${AppConstants.heroHeadlineLead} ',
              style: headlineStyle,
              children: [
                TextSpan(
                  text: AppConstants.heroHeadlineAccent,
                  style: headlineStyle.copyWith(
                    color: AppColors.gold(isDark),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        RevealOnScroll(
          delay: const Duration(milliseconds: 220),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              AppConstants.heroSubhead,
              style: AppTextStyles.bodyLarge
                  .copyWith(color: AppColors.textSecondary(isDark)),
            ),
          ),
        ),
        const SizedBox(height: 40),
        RevealOnScroll(
          delay: const Duration(milliseconds: 300),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              PremiumButton(
                label: 'See the work',
                trailingIcon: Icons.arrow_forward,
                onTap: onPrimaryCta ?? () {},
              ),
              PremiumButton(
                label: 'Start a conversation',
                variant: PremiumButtonVariant.outline,
                onTap: onSecondaryCta ?? () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvailabilityPill extends StatefulWidget {
  const _AvailabilityPill();
  @override
  State<_AvailabilityPill> createState() => _AvailabilityPillState();
}

class _AvailabilityPillState extends State<_AvailabilityPill>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface(isDark).withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.border(isDark)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: Tween(begin: 0.35, end: 1.0).animate(_c),
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            AppConstants.availability,
            style: AppTextStyles.labelMedium
                .copyWith(color: AppColors.textSecondary(isDark)),
          ),
        ],
      ),
    );
  }
}

// ── Metrics strip ─────────────────────────────────────────────────────────────

class _MetricsStrip extends StatelessWidget {
  const _MetricsStrip();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveUtil.isMobile(context);
    final metrics = AppConstants.heroMetrics;

    final items = <Widget>[];
    for (var i = 0; i < metrics.length; i++) {
      items.add(
        RevealOnScroll(
          delay: Duration(milliseconds: 120 * i),
          child: _MetricItem(
            value: metrics[i][0],
            suffix: metrics[i][1],
            label: metrics[i][2],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 8 : 24),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border(isDark)),
          bottom: BorderSide(color: AppColors.border(isDark)),
        ),
      ),
      child: isMobile
          ? Wrap(
              spacing: 32,
              runSpacing: 28,
              children: items,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  Expanded(child: items[i]),
                  if (i < items.length - 1)
                    Container(
                      width: 1,
                      height: 46,
                      color: AppColors.border(isDark),
                    ),
                ],
              ],
            ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({
    required this.value,
    required this.suffix,
    required this.label,
  });

  final String value;
  final String suffix;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final numeric = num.tryParse(value) ?? 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        numeric > 0
            ? AnimatedMetric(
                value: numeric,
                suffix: suffix,
                style: AppTextStyles.displaySmall.copyWith(
                  color: AppColors.textPrimary(isDark),
                  fontSize: 40,
                ),
              )
            : Text('$value$suffix',
                style: AppTextStyles.displaySmall.copyWith(
                  color: AppColors.textPrimary(isDark),
                  fontSize: 40,
                )),
        const SizedBox(height: 6),
        Text(
          label,
          style: AppTextStyles.labelMedium
              .copyWith(color: AppColors.textMuted(isDark)),
        ),
      ],
    );
  }
}

// ── Trust strip ───────────────────────────────────────────────────────────────

class _TrustStrip extends StatelessWidget {
  const _TrustStrip();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RevealOnScroll(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 28,
        runSpacing: 14,
        children: [
          Text(
            'Work shipped across'.toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.textMuted(isDark),
              letterSpacing: 1.6,
            ),
          ),
          ...AppConstants.trustedBy.map(
            (name) => Text(
              name,
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.textSecondary(isDark),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Live system card — the differentiator ─────────────────────────────────────

class LiveSystemCard extends StatefulWidget {
  const LiveSystemCard({super.key});
  @override
  State<LiveSystemCard> createState() => _LiveSystemCardState();
}

class _LiveSystemCardState extends State<LiveSystemCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..repeat(reverse: true);

  final _rng = math.Random();
  Timer? _ticker;

  // symbol, price, deltaPercent
  late final List<List<dynamic>> _rows = [
    ['KSE100', 78420.5, 0.62],
    ['OGDC', 198.40, 1.21],
    ['HBL', 132.85, -0.34],
    ['LUCK', 845.10, 0.18],
    ['ENGRO', 312.75, -0.77],
  ];
  int _latency = 42;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(milliseconds: 1700), (_) {
      if (!mounted) return;
      setState(() {
        final i = _rng.nextInt(_rows.length);
        final delta = (_rng.nextDouble() * 1.6 - 0.8);
        final price = (_rows[i][1] as double) * (1 + delta / 100);
        _rows[i] = [_rows[i][0], price, delta];
        _latency = 28 + _rng.nextInt(34);
      });
    });
  }

  @override
  void dispose() {
    _pulse.dispose();
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return RevealOnScroll(
      delay: const Duration(milliseconds: 260),
      offsetY: 36,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card(isDark),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border(isDark)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.07),
              blurRadius: 40,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            _header(isDark),
            Divider(height: 1, color: AppColors.border(isDark)),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Column(
                children: [
                  for (final r in _rows) _tickerRow(isDark, r),
                ],
              ),
            ),
            Divider(height: 1, color: AppColors.border(isDark)),
            _footer(isDark),
          ],
        ),
      ),
    );
  }

  Widget _header(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        children: [
          Row(
            children: [
              _dot(const Color(0xFFE0A8A0)),
              const SizedBox(width: 6),
              _dot(const Color(0xFFE6CB95)),
              const SizedBox(width: 6),
              _dot(const Color(0xFFA8C2A0)),
            ],
          ),
          const SizedBox(width: 16),
          Text('ktrade · live session',
              style: AppTextStyles.mono.copyWith(
                color: AppColors.textMuted(isDark),
                fontSize: 12,
              )),
          const Spacer(),
          FadeTransition(
            opacity: Tween(begin: 0.4, end: 1.0).animate(_pulse),
            child: Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                      color: AppColors.success, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text('LIVE',
                    style: AppTextStyles.mono.copyWith(
                      color: AppColors.success,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );

  Widget _tickerRow(bool isDark, List<dynamic> r) {
    final symbol = r[0] as String;
    final price = r[1] as double;
    final delta = r[2] as double;
    final up = delta >= 0;
    final color = up ? AppColors.success : AppColors.error;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Text(symbol,
                style: AppTextStyles.mono.copyWith(
                  color: AppColors.textPrimary(isDark),
                  fontWeight: FontWeight.w600,
                )),
          ),
          Expanded(child: _Sparkline(up: up, color: color)),
          const SizedBox(width: 16),
          SizedBox(
            width: 86,
            child: Text(
              price.toStringAsFixed(2),
              textAlign: TextAlign.right,
              style: AppTextStyles.mono
                  .copyWith(color: AppColors.textPrimary(isDark)),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 64,
            padding: const EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(up ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    size: 16, color: color),
                Text('${delta.abs().toStringAsFixed(2)}%',
                    style: AppTextStyles.mono
                        .copyWith(color: color, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _footer(bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      child: Row(
        children: [
          Icon(Icons.bolt_outlined, size: 15, color: AppColors.gold(isDark)),
          const SizedBox(width: 6),
          Text('feed latency ',
              style: AppTextStyles.mono.copyWith(
                  color: AppColors.textMuted(isDark), fontSize: 12)),
          Text('${_latency}ms',
              style: AppTextStyles.mono.copyWith(
                  color: AppColors.gold(isDark),
                  fontSize: 12,
                  fontWeight: FontWeight.w700)),
          const Spacer(),
          Text('5,000 concurrent',
              style: AppTextStyles.mono.copyWith(
                  color: AppColors.textMuted(isDark), fontSize: 12)),
        ],
      ),
    );
  }
}

class _Sparkline extends StatelessWidget {
  const _Sparkline({required this.up, required this.color});
  final bool up;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 22,
      child: CustomPaint(
        painter: _SparkPainter(up: up, color: color),
        size: const Size(double.infinity, 22),
      ),
    );
  }
}

class _SparkPainter extends CustomPainter {
  _SparkPainter({required this.up, required this.color});
  final bool up;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Deterministic pseudo wave so it reads as a chart, not noise.
    final pts = up
        ? [0.7, 0.55, 0.62, 0.4, 0.45, 0.25, 0.12]
        : [0.25, 0.4, 0.32, 0.5, 0.46, 0.68, 0.82];
    final path = Path();
    for (var i = 0; i < pts.length; i++) {
      final x = size.width * (i / (pts.length - 1));
      final y = size.height * pts[i];
      i == 0 ? path.moveTo(x, y) : path.lineTo(x, y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparkPainter old) =>
      old.up != up || old.color != color;
}

// ── Hero backdrop — faint chart grid + soft sand glow (no blobs) ──────────────

class _HeroBackdropPainter extends CustomPainter {
  _HeroBackdropPainter({required this.isDark});
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    // Soft warm radial highlight, top-right.
    final glow = Paint()
      ..shader = RadialGradient(
        colors: [
          (isDark ? AppColors.darkGold : AppColors.lightGold)
              .withValues(alpha: isDark ? 0.10 : 0.08),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.86, size.height * 0.18),
        radius: size.width * 0.5,
      ));
    canvas.drawRect(Offset.zero & size, glow);

    // Faint vertical hairlines — a quiet nod to a trading grid.
    final line = Paint()
      ..color = (isDark ? Colors.white : Colors.black)
          .withValues(alpha: isDark ? 0.03 : 0.025)
      ..strokeWidth = 1;
    const gap = 96.0;
    for (double x = gap; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), line);
    }
  }

  @override
  bool shouldRepaint(covariant _HeroBackdropPainter old) =>
      old.isDark != isDark;
}
