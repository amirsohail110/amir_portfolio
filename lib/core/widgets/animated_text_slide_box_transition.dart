import 'package:flutter/material.dart';
import 'animated_slide_box.dart';

/// A text-reveal animation where a coloured box sweeps across the text then
/// recedes, leaving the text sliding up into view.
///
/// Phase 1 [0.00 → 0.40]: box grows from 0 → textWidth (covers text).
/// Phase 2 [0.40 → 0.75]: erase box grows from 0 → textWidth (uncovers).
/// Phase 3 [0.60 → 1.00]: text slides up from below into its final position.
class AnimatedTextSlideBoxTransition extends StatefulWidget {
  const AnimatedTextSlideBoxTransition({
    super.key,
    required this.controller,
    required this.text,
    required this.textStyle,
    this.coverColor = Colors.transparent,
    this.boxColor = Colors.black,
    this.maxLines = 1,
    this.textAlign,
  });

  final AnimationController controller;
  final String text;
  final TextStyle textStyle;

  /// Background colour that the erase box uses — should match the page bg so
  /// it appears the text is being revealed from behind the surface.
  final Color coverColor;

  /// The wipe-box colour.
  final Color boxColor;

  final int maxLines;
  final TextAlign? textAlign;

  @override
  State<AnimatedTextSlideBoxTransition> createState() =>
      _AnimatedTextSlideBoxTransitionState();
}

class _AnimatedTextSlideBoxTransitionState
    extends State<AnimatedTextSlideBoxTransition> {
  late Animation<double> _visibleBox;
  late Animation<double> _invisibleBox;
  late Animation<RelativeRect> _textPosition;
  late Size _textSize;

  @override
  void initState() {
    super.initState();
    _textSize = _measureText();
    _buildAnimations();
  }

  @override
  void didUpdateWidget(AnimatedTextSlideBoxTransition oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.textStyle != widget.textStyle ||
        oldWidget.maxLines != widget.maxLines) {
      _textSize = _measureText();
      _buildAnimations();
    }
  }

  void _buildAnimations() {
    final w = _textSize.width;
    final h = _textSize.height;

    _visibleBox = Tween<double>(begin: 0, end: w).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.0, 0.40, curve: Curves.fastOutSlowIn),
      ),
    );

    _invisibleBox = Tween<double>(begin: 0, end: w).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.40, 0.75, curve: Curves.fastOutSlowIn),
      ),
    );

    _textPosition = RelativeRectTween(
      begin: RelativeRect.fromSize(
        Rect.fromLTWH(0, h, w, h),
        Size(w, h),
      ),
      end: RelativeRect.fromSize(
        Rect.fromLTWH(0, 0, w, h),
        Size(w, h),
      ),
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.60, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  Size _measureText() {
    final painter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.textStyle),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: 2000);
    return painter.size;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: SizedBox(
        height: _textSize.height,
        width: _textSize.width,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // The wipe box overlay
            AnimatedSlideBox(
              controller: widget.controller,
              height: _textSize.height,
              width: _textSize.width,
              coverColor: widget.coverColor,
              boxColor: widget.boxColor,
              visibleBoxAnimation: _visibleBox,
              invisibleBoxAnimation: _invisibleBox,
            ),
            // Text slides up from below
            PositionedTransition(
              rect: _textPosition,
              child: Text(
                widget.text,
                style: widget.textStyle,
                textAlign: widget.textAlign,
                maxLines: widget.maxLines,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
