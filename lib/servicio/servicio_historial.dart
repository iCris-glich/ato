class ServicioHistorial {
  ServicioHistorial._();
  static final ServicioHistorial instance = ServicioHistorial._();

  final List<Map<String, String>> historial = [];

  void agregarRegistro({
    required String documento,
    required String fecha,
    required String hora,
    required String beneficiado,
  }) {
    historial.add({
      'documento': documento,
      'fecha': fecha,
      'hora': hora,
      'beneficiado': beneficiado,
    });
  }

  List<Map<String, String>> obtenerHistorial() {
    return historial;
  }
}
