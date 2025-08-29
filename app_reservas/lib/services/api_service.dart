import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/appointment.dart';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:4000/api"; // Cambia si usas dispositivo real
  static String? token;

  static Future<bool> login(String email, String password, String? fcmToken) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password, "fcmToken": fcmToken}),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      token = data["token"];
      return true;
    }
    return false;
  }

  static Future<bool> register(String nombre, String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"nombre": nombre, "email": email, "password": password}),
    );
    return res.statusCode == 200;
  }

  static Future<bool> crearCita(String fecha, String hora, String motivo) async {
    final res = await http.post(
      Uri.parse("$baseUrl/citas"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"fecha": fecha, "hora": hora, "motivo": motivo}),
    );
    return res.statusCode == 200;
  }

  static Future<List<Appointment>> getMisCitas() async {
    final res = await http.get(
      Uri.parse("$baseUrl/citas/mine"),
      headers: {"Authorization": "Bearer $token"},
    );
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.map((j) => Appointment.fromJson(j)).toList();
    }
    return [];
  }
}
