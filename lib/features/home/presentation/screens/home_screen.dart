import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/orb_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('INFLECTION', style: textTheme.displayLarge),
              const SizedBox(height: 80),
              OrbWidget(
                onTap: () async {
                  // Deja respirar el pulso táctil antes de cruzar el portal.
                  await Future<void>.delayed(
                      const Duration(milliseconds: 180));
                  if (context.mounted) {
                    context.pushNamed('dashboard');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
