import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/principal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bienvenida extends StatelessWidget {
  const Bienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenido a HabitApp')),
      body: Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Escribe tu nombre',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Open route'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => const Principal(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
