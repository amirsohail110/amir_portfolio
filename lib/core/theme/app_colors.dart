import 'package:flutter/material.dart';

/// Warm, editorial FinTech palette — ivory / sand / charcoal / espresso
/// with muted gold + copper accents. Light is the primary mode; espresso
/// dark is the toggle. No blue, no purple, no neon.
///
/// The theme-aware helpers at the bottom keep the same API the widgets
/// already rely on (`AppColors.background(isDark)` etc.), so swapping the
/// underlying values re-skins the whole site at once.
class AppColors {
  AppColors._();

  // ── Brand accents (shared, nudged per-theme via helpers) ─────────────────
  /// Muted gold — the primary accent. `primary` keeps the legacy name so
  /// existing references resolve, but it now reads as warm gold.
  static const Color primary = Color(0xFFB0853F);
  static const Color primaryStrong = Color(0xFF8C6529);
  static const Color primaryGlow = Color(0x33B0853F);
  static const Color primarySoft = Color(0x14B0853F);

  /// Copper — secondary highlight for hover states and detail accents.
  static const Color copper = Color(0xFF9C6B3F);
  static const Color copperSoft = Color(0x149C6B3F);
  static const Color accent2 = copper; // legacy alias

  // ── Status (warm-tuned, used sparingly) ──────────────────────────────────
  static const Color success = Color(0xFF5A7D5A); // sage
  static const Color warning = Color(0xFFC08A2E);
  static const Color error = Color(0xFFB04A3A); // terracotta

  static const Color transparent = Colors.transparent;

  // ── Espresso dark palette ────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF14110D);
  static const Color darkBackgroundSecondary = Color(0xFF100D0A);
  static const Color darkCard = Color(0xFF1E1A14);
  static const Color darkCardHover = Color(0xFF26201A);
  static const Color darkSurface = Color(0xFF1A1610);
  static const Color darkTextPrimary = Color(0xFFF2EDE3); // warm ivory ink
  static const Color darkTextSecondary = Color(0xFFB9AE9C);
  static const Color darkTextMuted = Color(0xFF82786A);
  static const Color darkBorder = Color(0xFF332C22);
  static const Color darkBorderSubtle = Color(0xFF241F19);
  static const Color darkGold = Color(0xFFC99A4E);
  static const Color darkCopper = Color(0xFFB5784A);

  // ── Warm ivory light palette (default) ───────────────────────────────────
  static const Color lightBackground = Color(0xFFF7F4EE); // ivory
  static const Color lightBackgroundSecondary = Color(0xFFF0EBE0); // soft sand
  static const Color lightCard = Color(0xFFFCFAF5); // warm white
  static const Color lightCardHover = Color(0xFFF4EFE4);
  static const Color lightSurface = Color(0xFFEDE6D9); // sand
  static const Color lightTextPrimary = Color(0xFF1F1B16); // rich charcoal
  static const Color lightTextSecondary = Color(0xFF5A5048); // espresso-muted
  static const Color lightTextMuted = Color(0xFF8C8175);
  static const Color lightBorder = Color(0xFFE2D9C8);
  static const Color lightBorderSubtle = Color(0xFFEDE6D9);
  static const Color lightGold = Color(0xFFB0853F);
  static const Color lightCopper = Color(0xFF9C6B3F);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFC79A4E), Color(0xFF9C6B3F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // legacy aliases kept so existing widgets keep compiling
  static const LinearGradient primaryGradient = goldGradient;
  static const LinearGradient accentGradient = goldGradient;

  static const LinearGradient darkBackgroundGradient = LinearGradient(
    colors: [Color(0xFF14110D), Color(0xFF0F0C09)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient lightBackgroundGradient = LinearGradient(
    colors: [Color(0xFFFAF7F1), Color(0xFFF0EBE0)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    colors: [Color(0xFF1E1A14), Color(0xFF181410)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient lightCardGradient = LinearGradient(
    colors: [Color(0xFFFCFAF5), Color(0xFFF4EEE2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient cardGradient(bool isDark) =>
      isDark ? darkCardGradient : lightCardGradient;

  static const Color borderAccent = primary;

  // ── Theme-aware helpers (stable API) ─────────────────────────────────────
  static Color background(bool isDark) =>
      isDark ? darkBackground : lightBackground;
  static Color backgroundSecondary(bool isDark) =>
      isDark ? darkBackgroundSecondary : lightBackgroundSecondary;
  static Color card(bool isDark) => isDark ? darkCard : lightCard;
  static Color cardHover(bool isDark) =>
      isDark ? darkCardHover : lightCardHover;
  static Color surface(bool isDark) => isDark ? darkSurface : lightSurface;
  static Color textPrimary(bool isDark) =>
      isDark ? darkTextPrimary : lightTextPrimary;
  static Color textSecondary(bool isDark) =>
      isDark ? darkTextSecondary : lightTextSecondary;
  static Color textMuted(bool isDark) =>
      isDark ? darkTextMuted : lightTextMuted;
  static Color border(bool isDark) => isDark ? darkBorder : lightBorder;
  static Color borderSubtle(bool isDark) =>
      isDark ? darkBorderSubtle : lightBorderSubtle;
  static Color gold(bool isDark) => isDark ? darkGold : lightGold;
  static Color copperAccent(bool isDark) => isDark ? darkCopper : lightCopper;
  static LinearGradient backgroundGradient(bool isDark) =>
      isDark ? darkBackgroundGradient : lightBackgroundGradient;
}
