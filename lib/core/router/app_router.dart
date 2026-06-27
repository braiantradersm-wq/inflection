import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/neuroscience/presentation/screens/neuroscience_modules_screen.dart';
import '../../features/neuroscience/presentation/screens/module_detail_screen.dart';
import '../../features/neuroscience/domain/entities/neuroscience_module.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/', // arranca en el Splash
    routes: [
      // --- SPLASH (entrada) ---
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),

      // --- HOME / Orbe interactivo (entrada alternativa, opcional) ---
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),

      // --- DASHBOARD (destino del splash; transición portal) ---
      GoRoute(
        path: '/dashboard',
        name: 'dashboard',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 450),
          reverseTransitionDuration: const Duration(milliseconds: 350),
          child: const DashboardScreen(),
          transitionsBuilder: (context, animation, secondary, child) {
            final curved =
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
            return FadeTransition(
              opacity: curved,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.92, end: 1.0).animate(curved),
                child: child,
              ),
            );
          },
        ),
      ),

      // --- NEUROCIENCIA + detalle ---
      GoRoute(
        path: '/neuroscience',
        name: 'neuroscience',
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 400),
          child: const NeuroscienceModulesScreen(),
          transitionsBuilder: (context, animation, secondary, child) {
            final curved =
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.04),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
        ),
        routes: [
          GoRoute(
            path: 'detail', // -> /neuroscience/detail
            name: 'moduleDetail',
            pageBuilder: (context, state) {
              final module = state.extra as NeuroscienceModule?;
              return CustomTransitionPage<void>(
                key: state.pageKey,
                transitionDuration: const Duration(milliseconds: 380),
                child: ModuleDetailScreen(module: module),
                transitionsBuilder: (context, animation, secondary, child) {
                  final curved = CurvedAnimation(
                      parent: animation, curve: Curves.easeOutCubic);
                  return FadeTransition(
                    opacity: curved,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.06, 0),
                        end: Offset.zero,
                      ).animate(curved),
                      child: child,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    ],
  );
}
