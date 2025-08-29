import 'package:flutter/material.dart';
import 'reservar_screen.dart';
import 'historial_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Menú Principal")),
  body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReservarScreen())),
                child: const Text("Reservar Cita"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HistorialScreen())),
                child: const Text("Historial de Citas"),
              ),
          ],
        ),
      ),
    );
  }
}
