import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/appointment.dart';

class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});
  @override
  HistorialScreenState createState() => HistorialScreenState();
}

class HistorialScreenState extends State<HistorialScreen> {
  List<Appointment> citas = [];

  @override
  void initState() {
    super.initState();
    _loadCitas();
  }

  void _loadCitas() async {
    final data = await ApiService.getMisCitas();
    setState(() => citas = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historial de Citas")),
      body: citas.isEmpty
          ? const Center(child: Text("No tienes citas"))
          : ListView.builder(
              itemCount: citas.length,
              itemBuilder: (ctx, i) {
                final c = citas[i];
                return ListTile(
                  title: Text(c.motivo),
                  subtitle: Text("${c.fecha} - ${c.hora}"),
                );
              },
            ),
    );
  }
}
