import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;

  void _login() async {
    setState(() => loading = true);
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    final ok = await ApiService.login(emailCtrl.text, passCtrl.text, fcmToken);
    if (!mounted) return;
    setState(() => loading = false);

    if (ok) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login fallido")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Reservas")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: passCtrl, obscureText: true, decoration: const InputDecoration(labelText: "Contraseña")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : _login,
              child: loading ? const CircularProgressIndicator() : const Text("Iniciar Sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
