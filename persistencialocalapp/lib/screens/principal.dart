import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/bienvenida.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Principal extends StatelessWidget {
  final SharedPreferences _preferencias;
  const Principal({super.key, required this._preferencias});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú principal')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(builder: (context) => Bienvenida(preferencias: _preferencias,)),
            );
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}