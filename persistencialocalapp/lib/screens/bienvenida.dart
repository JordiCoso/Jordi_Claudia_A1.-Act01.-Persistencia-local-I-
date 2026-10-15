import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:persistencialocalapp/models/usuario.dart';
import 'package:persistencialocalapp/screens/principal.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';

class Bienvenida extends StatefulWidget {
  final PreferenciasService _preferenciasService;

  const Bienvenida({super.key, required this._preferenciasService});

  @override
  State<Bienvenida> createState() => _BienvenidaState();
}

class _BienvenidaState extends State<Bienvenida> {
  final _nombreController = TextEditingController();
  final _numeroController = TextEditingController();

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
      appBar: AppBar(title: const Text('Bienvenido a HabitosApp')),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              onChanged: _validarInput,
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Escribe tu nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: _validarInput,
              controller: _numeroController,
              decoration: InputDecoration(
                labelText: 'Numero habitos',
                hintText: 'Escribe numero de hábitos diarios',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validoAvanzar ? _botonContinuar : null,
              child: const Text('Iniciar'),
            ),
          ],
        ),
      ),
    );
  }

  void _botonContinuar() {

    String _nombre = _nombreController.text.trim();
    int _numberoHabitos = int.parse(_numeroController.text.trim());

    final Usuario _usuario = new Usuario(nombre: _nombre, numeroHabitos: _numberoHabitos);

    widget._preferenciasService.guardarUsuario(_usuario);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (context) =>
            Principal(preferenciasService: widget._preferenciasService, usuario: _usuario),
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