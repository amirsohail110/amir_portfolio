import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Animated typing-effect widget that cycles through a list of strings.
class AnimatedTextWidget extends StatefulWidget {
  const AnimatedTextWidget({
    super.key,
    required this.texts,
    this.typingSpeed = const Duration(milliseconds: 80),
    this.deletingSpeed = const Duration(milliseconds: 40),
    this.pauseDuration = const Duration(milliseconds: 1800),
    this.style,
    this.cursorColor,
  });

  final List<String> texts;
  final Duration typingSpeed;
  final Duration deletingSpeed;
  final Duration pauseDuration;
  final TextStyle? style;
  final Color? cursorColor;

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
  String _displayText = '';
  int _textIndex = 0;
  bool _isDeleting = false;
  bool _isPaused = false;
  Timer? _timer;

  late AnimationController _cursorController;
  late Animation<double> _cursorOpacity;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);

    _cursorOpacity = Tween<double>(begin: 0, end: 1).animate(_cursorController);

    _startTyping();
  }

  void _startTyping() {
    _scheduleNext();
  }

  void _scheduleNext() {
    if (!mounted) return;

    final currentText = widget.texts[_textIndex];

    if (_isPaused) {
      _timer = Timer(widget.pauseDuration, () {
        if (!mounted) return;
        setState(() {
          _isPaused = false;
          _isDeleting = true;
        });
        _scheduleNext();
      });
      return;
    }

    if (_isDeleting) {
      if (_displayText.isEmpty) {
        setState(() {
          _isDeleting = false;
          _textIndex = (_textIndex + 1) % widget.texts.length;
        });
        _scheduleNext();
        return;
      }
      _timer = Timer(widget.deletingSpeed, () {
        if (!mounted) return;
        setState(() {
          _displayText = _displayText.substring(0, _displayText.length - 1);
        });
        _scheduleNext();
      });
    } else {
      if (_displayText.length == currentText.length) {
        setState(() => _isPaused = true);
        _scheduleNext();
        return;
      }
      _timer = Timer(widget.typingSpeed, () {
        if (!mounted) return;
        setState(() {
          _displayText = currentText.substring(0, _displayText.length + 1);
        });
        _scheduleNext();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = widget.style ?? AppTextStyles.headlineMedium;
    final cursorColor = widget.cursorColor ?? AppColors.primary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(_displayText, style: effectiveStyle),
        AnimatedBuilder(
          animation: _cursorOpacity,
          builder: (context, _) {
            return Opacity(
              opacity: _cursorOpacity.value,
              child: Container(
                width: 2.5,
                height: effectiveStyle.fontSize != null
                    ? effectiveStyle.fontSize! * 1.2
                    : 24,
                margin: const EdgeInsets.only(left: 2),
                decoration: BoxDecoration(
                  color: cursorColor,
                  borderRadius: BorderRadius.circular(1),
                  boxShadow: [
                    BoxShadow(
                      color: cursorColor.withValues(alpha: 0.6),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
