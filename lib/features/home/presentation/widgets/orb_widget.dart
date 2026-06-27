import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_theme.dart';

/// El Orbe: firma visual de INFLECTION.
/// - Respira de forma continua (animación idle).
/// - Al tocarlo: pulso táctil háptico + pulso visual rápido.
/// - No conoce su acción: la recibe vía [onTap].
class OrbWidget extends StatefulWidget {
  const OrbWidget({
    super.key,
    required this.onTap,
    this.size = 220,
  });

  /// Acción a ejecutar al tocar el Orbe.
  final VoidCallback onTap;

  /// Diámetro base del Orbe.
  final double size;

  @override
  State<OrbWidget> createState() => _OrbWidgetState();
}

class _OrbWidgetState extends State<OrbWidget> with TickerProviderStateMixin {
  // Animación continua: el Orbe "respira".
  late final AnimationController _breathController;
  late final Animation<double> _breathScale;

  // Animación puntual: el pulso rápido al tocar.
  late final AnimationController _tapController;
  late final Animation<double> _tapScale;

  @override
  void initState() {
    super.initState();

    // --- Respiración idle (lenta, sutil, en loop) ---
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);

    _breathScale = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );

    // --- Pulso rápido al tap (contrae y rebota) ---
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );

    _tapScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.90)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 35,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.90, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)),
        weight: 65,
      ),
    ]).animate(_tapController);
  }

  @override
  void dispose() {
    _breathController.dispose();
    _tapController.dispose();
    super.dispose();
  }

  void _handleTap() {
    // 1. Feedback táctil: pulso háptico rápido.
    HapticFeedback.mediumImpact();
    // 2. Feedback visual: dispara el pulso desde el inicio.
    _tapController.forward(from: 0);
    // 3. Acción externa.
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: Listenable.merge([_breathController, _tapController]),
        builder: (context, child) {
          final double scale = _breathScale.value * _tapScale.value;
          // El brillo "respira" junto con el tamaño (0..1).
          final double glow = (_breathScale.value - 0.97) / 0.06;

          return Transform.scale(
            scale: scale,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                // Gradiente radial: da volumen de esfera.
                gradient: const RadialGradient(
                  center: Alignment(-0.3, -0.3),
                  radius: 0.95,
                  colors: [
                    AppTheme.orbeCian,
                    AppTheme.orbePurpura,
                  ],
                  stops: [0.1, 1.0],
                ),
                // Halo de luz exterior que pulsa con la respiración.
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.orbeCian
                        .withValues(alpha: 0.25 + glow * 0.25),
                    blurRadius: 40 + glow * 30,
                    spreadRadius: 4 + glow * 6,
                  ),
                  BoxShadow(
                    color: AppTheme.orbePurpura
                        .withValues(alpha: 0.20 + glow * 0.20),
                    blurRadius: 70 + glow * 30,
                    spreadRadius: 8 + glow * 8,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
