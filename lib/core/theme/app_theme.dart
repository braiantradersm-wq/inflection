import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // Colores Base de Identidad
  static const Color blackAbsoluto = Color(0xFF000000);
  static const Color whitePuro = Color(0xFFFFFFFF);

  // Paleta del Orbe (Cian a Púrpura)
  static const Color orbeCian = Color(0xFF00E5FF);
  static const Color orbePurpura = Color(0xFF651FFF);

  // Firma visual: el gradiente del Orbe, reutilizable.
  static const LinearGradient orbeGradient = LinearGradient(
    colors: [orbeCian, orbePurpura],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: blackAbsoluto,

      // ColorScheme explícito: la fuente de verdad para Material 3.
      colorScheme: const ColorScheme.dark(
        primary: orbeCian,
        secondary: orbePurpura,
        surface: blackAbsoluto,
        onPrimary: blackAbsoluto,
        onSurface: whitePuro,
      ),

      // AppBar coherente con el negro absoluto (sin tinte M3).
      appBarTheme: const AppBarTheme(
        backgroundColor: blackAbsoluto,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),

      // Tipografía (limpia y tecnológica).
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: whitePuro,
          letterSpacing: 1.5,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: whitePuro.withValues(alpha: 0.85),
        ),
      ),
    );
  }
}
