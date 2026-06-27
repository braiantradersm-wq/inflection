import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Cada pilar con su acción. null = aún sin destino.
    final pillars = <({String title, VoidCallback? onTap})>[
      (title: 'Evaluación de Enfoque', onTap: null),
      (
        title: 'Módulos de Neurociencia',
        onTap: () => context.pushNamed('neuroscience'),
      ),
      (title: 'Métricas de Soberanía', onTap: null),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PANEL',
          style: TextStyle(letterSpacing: 2, fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final pillar in pillars) ...[
                _PillarCard(title: pillar.title, onTap: pillar.onTap),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Tarjeta de pilar: oscura, minimalista, con borde sutil.
/// Privada al dashboard por ahora; se extrae si se reutiliza.
class _PillarCard extends StatelessWidget {
  const _PillarCard({required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool enabled = onTap != null;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: enabled
          ? () {
              HapticFeedback.lightImpact();
              onTap!();
            }
          : null,
      child: Opacity(
        // Los pilares aún sin destino se ven atenuados: comunican "próximamente".
        opacity: enabled ? 1.0 : 0.45,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF0A0A0A),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.whitePuro.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 3,
                height: 28,
                decoration: BoxDecoration(
                  gradient: AppTheme.orbeGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.whitePuro,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppTheme.whitePuro.withValues(alpha: 0.3),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
