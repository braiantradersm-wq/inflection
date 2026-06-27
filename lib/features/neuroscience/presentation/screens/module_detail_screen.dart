import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/neuroscience_module.dart';

class ModuleDetailScreen extends StatelessWidget {
  const ModuleDetailScreen({super.key, required this.module});

  /// Puede ser null si se llega por deep-link sin `extra` (mock data).
  final NeuroscienceModule? module;

  // Color de texto principal: blanco al 0.85 para no cansar la vista.
  static final Color _textPrimary = AppTheme.whitePuro.withValues(alpha: 0.85);
  static final Color _textSecondary =
      AppTheme.whitePuro.withValues(alpha: 0.55);

  @override
  Widget build(BuildContext context) {
    final m = module;

    // Salida segura si no llegó el módulo.
    if (m == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text(
            'Módulo no disponible.',
            style: GoogleFonts.inter(color: _textPrimary, fontSize: 16),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.blackAbsoluto,
        title: Text(
          'MÓDULO',
          style: GoogleFonts.inter(
            color: _textPrimary,
            letterSpacing: 2,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Duración con acento cian.
              Text(
                '${m.durationMinutes} MIN · LECTURA',
                style: GoogleFonts.inter(
                  color: AppTheme.orbeCian.withValues(alpha: 0.85),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 16),

              // Título principal (opacidad plena).
              Text(
                m.title,
                style: GoogleFonts.inter(
                  color: AppTheme.whitePuro,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 12),

              // Resumen.
              Text(
                m.summary,
                style: GoogleFonts.inter(
                  color: _textSecondary,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),

              // Separador sutil con el gradiente del Orbe.
              Container(
                height: 2,
                width: 60,
                decoration: BoxDecoration(
                  gradient: AppTheme.orbeGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              const SizedBox(height: 28),

              // Cuerpo (mock). Texto principal en blanco 0.85.
              Text(
                _mockBody,
                style: GoogleFonts.inter(
                  color: _textPrimary,
                  fontSize: 16,
                  height: 1.65, // interlineado amplio = legibilidad
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Contenido de relleno temporal para visualizar la maqueta.
  static const String _mockBody =
      'Este módulo desarrolla los mecanismos neurológicos que sostienen el '
      'comportamiento bajo control deliberado. El objetivo no es informar: es '
      'reconfigurar.\n\n'
      'Cada concepto se presenta como una palanca operativa —algo que el sujeto '
      'puede aplicar para alterar su propia respuesta— y no como dato pasivo.\n\n'
      'La soberanía individual empieza en la comprensión precisa de los sistemas '
      'que, sin entrenamiento, te gobiernan por defecto.';
}
