import 'package:flutter/material.dart';

/// A box that slides across and reveals content beneath it.
/// Credit: inspired by davidcobbina.com animation technique.
class AnimatedSlideBox extends StatelessWidget {
  const AnimatedSlideBox({
    super.key,
    required this.controller,
    required this.height,
    required this.width,
    this.boxColor = Colors.black,
    this.coverColor = Colors.transparent,
    this.visibleBoxAnimation,
    this.invisibleBoxAnimation,
  });

  final AnimationController controller;
  final double height;
  final double width;
  final Color boxColor;
  final Color coverColor;
  final Animation<double>? visibleBoxAnimation;
  final Animation<double>? invisibleBoxAnimation;

  @override
  Widget build(BuildContext context) {
    final visible =
        visibleBoxAnimation ??
        Tween<double>(begin: 0, end: width).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0, 0.45, curve: Curves.fastOutSlowIn),
          ),
        );
    final invisible =
        invisibleBoxAnimation ??
        Tween<double>(begin: 0, end: width).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.45, 0.85, curve: Curves.fastOutSlowIn),
          ),
        );

    return AnimatedBuilder(
      animation: controller,
      builder: (_, _) {
        return Stack(
          children: [
            // Solid cover that grows (the reveal box)
            Positioned(
              left: 0,
              child: Container(
                width: visible.value,
                height: height,
                color: boxColor,
              ),
            ),
            // Transparent erase box that chases the cover
            Positioned(
              left: invisible.value,
              child: Container(width: width, height: height, color: coverColor),
            ),
          ],
        );
      },
    );
  }
}
