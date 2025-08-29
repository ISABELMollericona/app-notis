import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReservarScreen extends StatefulWidget {
  const ReservarScreen({super.key});
  @override
  ReservarScreenState createState() => ReservarScreenState();
}

class ReservarScreenState extends State<ReservarScreen> {
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _initNotifications();
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // Eliminado método duplicado

  void _initNotifications() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(android: androidSettings);
    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> scheduleNotification(DateTime citaDateTime) async {
  var scheduledTime = citaDateTime.subtract(const Duration(minutes: 15));
  final tzScheduled = tz.TZDateTime.from(scheduledTime, tz.local);
    var androidDetails = const AndroidNotificationDetails('cita_channel', 'Recordatorio de Cita', channelDescription: 'Notifica 15 minutos antes de la cita');
    var generalNotificationDetails = NotificationDetails(android: androidDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Recordatorio de cita',
      'Tu cita es en 15 minutos',
      tzScheduled,
      generalNotificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final motivoCtrl = TextEditingController();

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (!mounted) return;
    if (date != null) setState(() => selectedDate = date);
  }

  Future<void> _pickTime() async {
  final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
  if (!mounted) return;
  if (time != null) setState(() => selectedTime = time);
  }

  void _guardar() async {
    if (selectedDate == null || selectedTime == null || motivoCtrl.text.isEmpty) return;

    final fecha = DateFormat('yyyy-MM-dd').format(selectedDate!);
    final hora = "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}";

    final citaDateTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    await scheduleNotification(citaDateTime);

    final ok = await ApiService.crearCita(fecha, hora, motivoCtrl.text);
    if (!mounted) return;
    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cita guardada")));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error al guardar cita")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reservar Cita")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: motivoCtrl, decoration: const InputDecoration(labelText: "Motivo")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _pickDate, child: const Text("Seleccionar Fecha")),
            if (selectedDate != null) Text(DateFormat('yyyy-MM-dd').format(selectedDate!)),
            ElevatedButton(onPressed: _pickTime, child: const Text("Seleccionar Hora")),
            if (selectedTime != null) Text("${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}"),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _guardar, child: const Text("Guardar Cita")),
          ],
        ),
      ),
    );
  }
}
