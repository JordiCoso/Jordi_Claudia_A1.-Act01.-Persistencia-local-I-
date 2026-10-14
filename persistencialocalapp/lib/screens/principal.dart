import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/bienvenida.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';

class Principal extends StatelessWidget {
  final PreferenciasService _preferenciasService;
  const Principal({super.key, required this._preferenciasService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú principal')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(builder: (context) => Bienvenida(preferenciasService: _preferenciasService)),
            );
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}