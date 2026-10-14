import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/principal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bienvenida extends StatelessWidget {
  final SharedPreferences _preferencias;

  const Bienvenida({super.key, required this._preferencias});

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
                _preferencias.setBool("primerInicio", false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) =>
                        Principal(preferencias: _preferencias),
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
