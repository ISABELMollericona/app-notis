class Appointment {
  final String id;
  final String motivo;
  final String fecha;
  final String hora;

  Appointment({
    required this.id,
    required this.motivo,
    required this.fecha,
    required this.hora,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'],
      motivo: json['motivo'],
      fecha: json['fecha'],
      hora: json['hora'],
    );
  }
}
