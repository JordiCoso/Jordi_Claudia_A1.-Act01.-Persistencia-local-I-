import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/principal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';

class Bienvenida extends StatefulWidget {
  final PreferenciasService _preferenciasService;

  const Bienvenida({super.key, required this._preferenciasService});

  @override
  State<Bienvenida> createState() => _BienvenidaState();
}

class _BienvenidaState extends State<Bienvenida> {
  final _nombreController = TextEditingController(text: 'Alex');
  final _numeroController = TextEditingController(text: '0');

  @override
  void dispose() {
    _nombreController.dispose();
    _numeroController.dispose();
    super.dispose();
  }

  bool _validoAvanzar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bienvenido a HabitApp')),
      body: Center(
        child: Column(
          children: [
            TextField(
              onChanged: _validarInput,
              controller: _nombreController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Escribe tu nombre',
              ),
            ),
            TextField(
              onChanged: _validarInput,
              controller: _numeroController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Escribe numero de hàbitos diarios',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Open route'),
              onPressed: _validoAvanzar ? _botonContinuar : null,
            ),
          ],
        ),
      ),
    );
  }

  void _botonContinuar() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) =>
            Principal(preferenciasService: widget._preferenciasService),
      ),
    );
  }

  void _validarInput(_) {
    _validoAvanzar = false;
    if (_comprobarNombre()) {
      if (_comprobarNumeroHabitos()) _validoAvanzar = true;
    }

    setState(() {}); // Actualizar cada vez que hay un cambio.
  }

  bool _comprobarNombre() {
    String? nombre = _nombreController.text.trim();
    return nombre == '' ? false : true;
  }

  bool _comprobarNumeroHabitos() {
    try {
      int numero = int.parse(_numeroController.text.trim());

      if (numero > 0) return true;
    } on FormatException {
      return false;
    }

    return false;
  }
}
