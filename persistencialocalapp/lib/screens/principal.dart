import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/bienvenida.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú principal')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(builder: (context) => const Bienvenida()),
            );
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}