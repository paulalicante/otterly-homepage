import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtterlyColors {
  // Backgrounds
  static const Color cream = Color(0xFFFFF8F0);
  static const Color warmWhite = Color(0xFFFFFDF9);
  static const Color sand = Color(0xFFF5E6D3);

  // Primary accent — warm coral
  static const Color coral = Color(0xFFE8785A);
  static const Color coralLight = Color(0xFFFAD4C8);
  static const Color coralDark = Color(0xFFCC5D42);

  // Secondary accent — soft teal
  static const Color teal = Color(0xFF5BA4A4);
  static const Color tealLight = Color(0xFFD4EDED);
  static const Color tealDark = Color(0xFF3D7A7A);

  // Neutral text
  static const Color textDark = Color(0xFF2D3436);
  static const Color textMedium = Color(0xFF636E72);
  static const Color textLight = Color(0xFF99A4A8);

  // Decorative
  static const Color sunYellow = Color(0xFFF9D77E);
  static const Color leafGreen = Color(0xFF7EC8A0);
}

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: OtterlyColors.cream,
      colorScheme: ColorScheme.light(
        primary: OtterlyColors.coral,
        secondary: OtterlyColors.teal,
        surface: OtterlyColors.warmWhite,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: OtterlyColors.textDark,
      ),
      textTheme: _textTheme,
    );
  }

  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: GoogleFonts.nunito(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: OtterlyColors.textDark,
        height: 1.1,
      ),
      displayMedium: GoogleFonts.nunito(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: OtterlyColors.textDark,
        height: 1.2,
      ),
      displaySmall: GoogleFonts.nunito(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: OtterlyColors.textDark,
        height: 1.3,
      ),
      headlineMedium: GoogleFonts.nunito(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: OtterlyColors.textDark,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: OtterlyColors.textDark,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: OtterlyColors.textMedium,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: OtterlyColors.textMedium,
        height: 1.5,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: OtterlyColors.textLight,
      ),
    );
  }
}
