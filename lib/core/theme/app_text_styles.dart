import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Type system: Fraunces (warm optical serif) for display + headlines,
/// Inter for body + UI. Editorial gravitas up top, neutral readability below.
///
/// Static styles default to the charcoal/ivory ink; widgets override the
/// color via `.copyWith(color: AppColors.textPrimary(isDark))` where they
/// need theme awareness.
class AppTextStyles {
  AppTextStyles._();

  // Fraunces display — optical sizing leans high-contrast at large sizes.
  static TextStyle _serif(
    double size, {
    FontWeight weight = FontWeight.w600,
    double height = 1.1,
    double spacing = -0.5,
    Color? color,
  }) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: weight,
        height: height,
        letterSpacing: spacing,
        color: color ?? AppColors.lightTextPrimary,
      );

  static TextStyle _sans(
    double size, {
    FontWeight weight = FontWeight.w400,
    double height = 1.6,
    double spacing = 0,
    Color? color,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        height: height,
        letterSpacing: spacing,
        color: color ?? AppColors.lightTextSecondary,
      );

  // ── Display (Fraunces) ────────────────────────────────────────────────────
  static TextStyle get displayLarge =>
      _serif(76, weight: FontWeight.w600, height: 1.04, spacing: -1.5);
  static TextStyle get displayMedium =>
      _serif(58, weight: FontWeight.w600, height: 1.06, spacing: -1.2);
  static TextStyle get displaySmall =>
      _serif(42, weight: FontWeight.w600, height: 1.1, spacing: -0.8);
  static TextStyle get headlineLarge =>
      _serif(34, weight: FontWeight.w600, height: 1.15, spacing: -0.5);
  static TextStyle get headlineMedium =>
      _serif(26, weight: FontWeight.w600, height: 1.2, spacing: -0.3);
  static TextStyle get headlineSmall =>
      _serif(21, weight: FontWeight.w600, height: 1.25, spacing: -0.2);
  static TextStyle get titleLarge =>
      _serif(19, weight: FontWeight.w600, height: 1.3, spacing: 0);

  // ── Titles / UI (Inter) ───────────────────────────────────────────────────
  static TextStyle get titleMedium =>
      _sans(16, weight: FontWeight.w600, height: 1.4,
          color: AppColors.lightTextPrimary);
  static TextStyle get titleSmall =>
      _sans(14, weight: FontWeight.w600, height: 1.4,
          color: AppColors.lightTextPrimary);

  // ── Body (Inter) ──────────────────────────────────────────────────────────
  static TextStyle get bodyLarge => _sans(19, height: 1.65);
  static TextStyle get bodyMedium => _sans(16, height: 1.65);
  static TextStyle get bodySmall => _sans(14, height: 1.6);

  // ── Labels (Inter) ────────────────────────────────────────────────────────
  static TextStyle get labelLarge => _sans(14,
      weight: FontWeight.w500, height: 1.4, spacing: 0.1,
      color: AppColors.lightTextPrimary);
  static TextStyle get labelMedium => _sans(12,
      weight: FontWeight.w500, height: 1.4, spacing: 0.4);
  static TextStyle get labelSmall => _sans(11,
      weight: FontWeight.w500, height: 1.4, spacing: 0.5,
      color: AppColors.lightTextMuted);

  // ── Accent (gold) ─────────────────────────────────────────────────────────
  static TextStyle get accentLarge => _sans(18,
      weight: FontWeight.w600, height: 1.4, color: AppColors.primary);
  static TextStyle get accentMedium => _sans(15,
      weight: FontWeight.w600, height: 1.4, color: AppColors.primary);
  static TextStyle get accentSmall => _sans(13,
      weight: FontWeight.w600, height: 1.4, spacing: 0.4,
      color: AppColors.primary);

  // Monospace for metrics / code / data labels.
  static TextStyle get codeStyle => GoogleFonts.jetBrainsMono(
      fontSize: 13, fontWeight: FontWeight.w500, height: 1.5,
      color: AppColors.primary);

  static TextStyle get mono => GoogleFonts.jetBrainsMono(
      fontSize: 13, fontWeight: FontWeight.w500, height: 1.4,
      letterSpacing: 0.2, color: AppColors.lightTextSecondary);

  // ── Nav ───────────────────────────────────────────────────────────────────
  static TextStyle get navLink => _sans(14,
      weight: FontWeight.w500, height: 1.4, spacing: 0.1,
      color: AppColors.lightTextSecondary);
  static TextStyle get navLinkActive => _sans(14,
      weight: FontWeight.w600, height: 1.4, spacing: 0.1,
      color: AppColors.lightTextPrimary);

  // Eyebrow / section tag — tracked Inter caps in gold.
  static TextStyle get sectionTag => GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.w600, height: 1.4,
      letterSpacing: 2.5, color: AppColors.primary);
}
