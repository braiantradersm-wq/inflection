import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../home/presentation/widgets/orb_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Tiempo en pantalla antes de transicionar.
  static const Duration _holdDuration = Duration(milliseconds: 3000);

  late final AnimationController _fadeController;
  late final Animation<double> _fadeIn;
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();

    // Fade-in del contenido al entrar.
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    // Tras el hold, transiciona al Dashboard.
    _navTimer = Timer(_holdDuration, _goToDashboard);
  }

  void _goToDashboard() {
    if (!mounted) return; // evita navegar si el widget ya se desmontó
    context.goNamed('dashboard');
  }

  @override
  void dispose() {
    _navTimer?.cancel(); // imprescindible: nada de timers huérfanos
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // El Orbe, en modo contemplativo: respira pero no es interactivo.
              const OrbWidget(onTap: _noop, size: 160),
              const SizedBox(height: 48),
              Text('INFLECTION', style: textTheme.displayLarge),
              const SizedBox(height: 14),
              Text(
                'OPTIMIZACIÓN CONDUCTUAL',
                style: TextStyle(
                  color: AppTheme.whitePuro.withValues(alpha: 0.40),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // El Orbe exige un onTap; en el splash no hace nada.
  static void _noop() {}
}
