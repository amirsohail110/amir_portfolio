import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// One-shot scroll reveal: fades and rises content into place the first time
/// it enters the viewport. Pass [delay] to stagger siblings. Respects the
/// platform "reduce motion" accessibility setting by skipping the animation.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offsetY = 28,
    this.duration = const Duration(milliseconds: 720),
    this.threshold = 0.08,
  });

  final Widget child;
  final Duration delay;
  final double offsetY;
  final Duration duration;
  final double threshold;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.duration);
  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );
  late final Animation<Offset> _slide = Tween<Offset>(
    begin: Offset(0, widget.offsetY / 100),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

  bool _triggered = false;

  void _onVisible(VisibilityInfo info) {
    if (_triggered || !mounted) return;
    if (info.visibleFraction >= widget.threshold) {
      _triggered = true;
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduceMotion) return widget.child;

    return VisibilityDetector(
      key: ValueKey('reveal-${widget.key ?? hashCode}'),
      onVisibilityChanged: _onVisible,
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child),
      ),
    );
  }
}

/// Animated count-up metric. Starts when scrolled into view. Supports a string
/// [prefix]/[suffix] (e.g. '50' + 'K+') so non-numeric flourishes stay intact.
class AnimatedMetric extends StatefulWidget {
  const AnimatedMetric({
    super.key,
    required this.value,
    this.suffix = '',
    this.prefix = '',
    required this.style,
    this.duration = const Duration(milliseconds: 1400),
  });

  final num value;
  final String suffix;
  final String prefix;
  final TextStyle style;
  final Duration duration;

  @override
  State<AnimatedMetric> createState() => _AnimatedMetricState();
}

class _AnimatedMetricState extends State<AnimatedMetric>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: widget.duration);
  late final Animation<double> _anim =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutExpo);
  bool _triggered = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _format(num current) {
    final isInt = widget.value % 1 == 0;
    final text = isInt
        ? current.round().toString()
        : current.toStringAsFixed(1);
    return '${widget.prefix}$text${widget.suffix}';
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduceMotion) {
      return Text(_format(widget.value), style: widget.style);
    }
    return VisibilityDetector(
      key: ValueKey('metric-${widget.key ?? hashCode}'),
      onVisibilityChanged: (info) {
        if (!_triggered && info.visibleFraction > 0.2 && mounted) {
          _triggered = true;
          _controller.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, _) =>
            Text(_format(widget.value * _anim.value), style: widget.style),
      ),
    );
  }
}
