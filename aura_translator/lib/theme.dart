import 'package:flutter/material.dart';

// Neon dark theme for Aura Translator
class AuraTheme {
  static const Color background = Color(0xFF0A0F1E);
  static const Color surface = Color(0xFF121A2C);
  static const Color neonCyan = Color(0xFF00F5FF);
  static const Color neonMagenta = Color(0xFFFF00F5);
  static const Color neonLime = Color(0xFFB8FF00);
  static const Color textPrimary = Color(0xFFE6F1FF);
  static const Color textSecondary = Color(0xFF9FB3C8);

  static ThemeData theme({Color accent = neonCyan}) {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: background,
      colorScheme: base.colorScheme.copyWith(
        primary: accent,
        secondary: neonMagenta,
        surface: surface,
        onSurface: textPrimary,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          color: textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0x33121A2C),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accent.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accent.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: accent, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
    );
  }

  // Neon glow helper
  static List<BoxShadow> neonGlow(Color color, {double blur = 24, double spread = 0}) => [
        BoxShadow(color: color.withOpacity(0.35), blurRadius: blur, spreadRadius: spread),
        BoxShadow(color: color.withOpacity(0.2), blurRadius: blur * 2, spreadRadius: spread + 1),
      ];
}

