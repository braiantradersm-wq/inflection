import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/neuroscience_module.dart';
import '../widgets/module_card.dart';

class NeuroscienceModulesScreen extends StatelessWidget {
  const NeuroscienceModulesScreen({super.key});

  // MOCK DATA — temporal. Se sustituye por un provider más adelante.
  static const List<NeuroscienceModule> _mockModules = [
    NeuroscienceModule(
      id: 'n01',
      title: 'Neuroplasticidad y Hábito',
      summary:
          'Cómo el cerebro reescribe sus circuitos bajo repetición deliberada.',
      durationMinutes: 12,
    ),
    NeuroscienceModule(
      id: 'n02',
      title: 'Dopamina y Sistema de Recompensa',
      summary: 'Arquitectura del impulso: anticipación, refuerzo y control.',
      durationMinutes: 15,
    ),
    NeuroscienceModule(
      id: 'n03',
      title: 'Corteza Prefrontal y Autocontrol',
      summary: 'El centro ejecutivo de la voluntad y la inhibición consciente.',
      durationMinutes: 18,
    ),
    NeuroscienceModule(
      id: 'n04',
      title: 'Amígdala y Regulación del Miedo',
      summary: 'Dominar la respuesta de amenaza para operar bajo presión.',
      durationMinutes: 14,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NEUROCIENCIA',
          style: TextStyle(letterSpacing: 2, fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          itemCount: _mockModules.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final module = _mockModules[index];
            return ModuleCard(
              index: index + 1,
              module: module,
              onTap: () {
                // Pasa la entidad completa vía `extra` (mock; sin repositorio aún).
                context.pushNamed('moduleDetail', extra: module);
              },
            );
          },
        ),
      ),
    );
  }
}
