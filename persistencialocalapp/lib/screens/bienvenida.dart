import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/principal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';

class Bienvenida extends StatelessWidget {
  final PreferenciasService _preferenciasService;

  const Bienvenida({super.key, required this._preferenciasService});

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
                _preferenciasService.setPrimerInicio(false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) =>
                        Principal(preferenciasService: _preferenciasService),
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
