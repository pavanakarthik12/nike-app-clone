import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppPalette {
  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF171717);
  static const Color accent = Color(0xFFF1C526);
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textMuted = Color(0xFFBDBDBD);
}

class AppTheme {
  static ThemeData get darkSneakerTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      scaffoldBackgroundColor: AppPalette.background,
      colorScheme: const ColorScheme.dark(
        primary: AppPalette.accent,
        secondary: AppPalette.accent,
        surface: AppPalette.surface,
      ),
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.oswald(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: AppPalette.textPrimary,
          letterSpacing: 2,
        ),
        headlineMedium: GoogleFonts.oswald(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppPalette.textPrimary,
          letterSpacing: 1.5,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppPalette.textPrimary,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          color: AppPalette.textMuted,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppPalette.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}
