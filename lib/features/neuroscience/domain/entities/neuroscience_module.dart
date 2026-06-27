/// Un módulo de neurociencia. Entidad pura de negocio.
class NeuroscienceModule {
  const NeuroscienceModule({
    required this.id,
    required this.title,
    required this.summary,
    required this.durationMinutes,
  });

  final String id;
  final String title;
  final String summary;
  final int durationMinutes;
}
