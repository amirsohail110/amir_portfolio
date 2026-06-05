import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static TextTheme _buildTextTheme(Color ink, Color body) {
    return GoogleFonts.interTextTheme().copyWith(
      // Display + headlines → Fraunces serif
      displayLarge: GoogleFonts.fraunces(
          fontSize: 60, fontWeight: FontWeight.w600, height: 1.05,
          letterSpacing: -1.2, color: ink),
      displayMedium: GoogleFonts.fraunces(
          fontSize: 46, fontWeight: FontWeight.w600, height: 1.08,
          letterSpacing: -1, color: ink),
      displaySmall: GoogleFonts.fraunces(
          fontSize: 36, fontWeight: FontWeight.w600, height: 1.12,
          letterSpacing: -0.6, color: ink),
      headlineLarge: GoogleFonts.fraunces(
          fontSize: 32, fontWeight: FontWeight.w600, height: 1.15,
          letterSpacing: -0.5, color: ink),
      headlineMedium: GoogleFonts.fraunces(
          fontSize: 26, fontWeight: FontWeight.w600, height: 1.2, color: ink),
      headlineSmall: GoogleFonts.fraunces(
          fontSize: 21, fontWeight: FontWeight.w600, height: 1.25, color: ink),
      titleLarge: GoogleFonts.fraunces(
          fontSize: 19, fontWeight: FontWeight.w600, height: 1.3, color: ink),
      // Titles + UI → Inter
      titleMedium: GoogleFonts.inter(
          fontSize: 16, fontWeight: FontWeight.w600, color: ink),
      titleSmall: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w600, color: ink),
      bodyLarge: GoogleFonts.inter(fontSize: 16, height: 1.65, color: body),
      bodyMedium: GoogleFonts.inter(fontSize: 14, height: 1.6, color: body),
      bodySmall: GoogleFonts.inter(fontSize: 12, height: 1.55, color: body),
      labelLarge: GoogleFonts.inter(
          fontSize: 14, fontWeight: FontWeight.w500, color: ink),
      labelMedium: GoogleFonts.inter(
          fontSize: 12, fontWeight: FontWeight.w500, color: body),
      labelSmall: GoogleFonts.inter(
          fontSize: 11, fontWeight: FontWeight.w400, color: body),
    );
  }

  static ThemeData _base({
    required Brightness brightness,
    required Color bg,
    required Color card,
    required Color ink,
    required Color body,
    required Color surface,
    required Color borderColor,
    required Color accent,
  }) {
    final isDark = brightness == Brightness.dark;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: bg,
      primaryColor: accent,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: accent,
        onPrimary: isDark ? AppColors.darkBackground : Colors.white,
        secondary: AppColors.copperAccent(isDark),
        onSecondary: isDark ? AppColors.darkBackground : Colors.white,
        surface: surface,
        onSurface: ink,
        error: AppColors.error,
        onError: Colors.white,
      ),
      textTheme: _buildTextTheme(ink, body),
      appBarTheme: AppBarTheme(
        backgroundColor: bg.withValues(alpha: 0.0),
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: ink),
        titleTextStyle: GoogleFonts.fraunces(
          fontSize: 20, fontWeight: FontWeight.w600, color: ink,
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: card,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: borderColor),
        ),
      ),
      dividerTheme: DividerThemeData(color: borderColor, thickness: 1),
      iconTheme: IconThemeData(color: body, size: 22),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all(accent.withValues(alpha: 0.5)),
        trackColor: WidgetStateProperty.all(Colors.transparent),
        radius: const Radius.circular(8),
        thickness: WidgetStateProperty.all(6),
      ),
    );
  }

  static ThemeData get lightTheme => _base(
        brightness: Brightness.light,
        bg: AppColors.lightBackground,
        card: AppColors.lightCard,
        ink: AppColors.lightTextPrimary,
        body: AppColors.lightTextSecondary,
        surface: AppColors.lightSurface,
        borderColor: AppColors.lightBorder,
        accent: AppColors.lightGold,
      );

  static ThemeData get darkTheme => _base(
        brightness: Brightness.dark,
        bg: AppColors.darkBackground,
        card: AppColors.darkCard,
        ink: AppColors.darkTextPrimary,
        body: AppColors.darkTextSecondary,
        surface: AppColors.darkSurface,
        borderColor: AppColors.darkBorder,
        accent: AppColors.darkGold,
      );
}
