import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/neuroscience_module.dart';

class ModuleCard extends StatelessWidget {
  const ModuleCard({
    super.key,
    required this.index,
    required this.module,
    required this.onTap,
  });

  final int index;
  final NeuroscienceModule module;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.whitePuro.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Índice con el gradiente del Orbe (ShaderMask).
            ShaderMask(
              shaderCallback: (bounds) =>
                  AppTheme.orbeGradient.createShader(bounds),
              child: Text(
                index.toString().padLeft(2, '0'),
                style: const TextStyle(
                  color: Colors.white, // base que el shader tiñe
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    module.title,
                    style: const TextStyle(
                      color: AppTheme.whitePuro,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    module.summary,
                    style: TextStyle(
                      color: AppTheme.whitePuro.withValues(alpha: 0.55),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${module.durationMinutes} MIN',
                    style: TextStyle(
                      color: AppTheme.orbeCian.withValues(alpha: 0.8),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
