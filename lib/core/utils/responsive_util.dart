import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

class ResponsiveUtil {
  ResponsiveUtil._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppConstants.mobileBreakpoint;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppConstants.mobileBreakpoint &&
        width < AppConstants.tabletBreakpoint;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppConstants.tabletBreakpoint;

  static double horizontalPadding(BuildContext context) {
    if (isMobile(context)) return AppConstants.sectionPaddingHorizontalMobile;
    return AppConstants.sectionPaddingHorizontalDesktop;
  }

  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    if (isDesktop(context)) return desktop;
    if (isTablet(context)) return tablet ?? desktop;
    return mobile;
  }

  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static EdgeInsets sectionPadding(BuildContext context) {
    final horizontal = horizontalPadding(context);
    return EdgeInsets.symmetric(
      horizontal: horizontal,
      vertical: AppConstants.sectionPaddingVertical,
    );
  }

  static int projectGridColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }
}
