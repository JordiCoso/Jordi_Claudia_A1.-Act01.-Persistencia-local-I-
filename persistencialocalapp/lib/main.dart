

import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/bienvenida.dart';
import 'package:persistencialocalapp/screens/principal.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(home: ComprobarInicio());
  }
}

Widget ComprobarInicio() {

  bool primerInicio = false;
  PreferenciasService hola = new PreferenciasService();

  return primerInicio ? Bienvenida() : Principal();

}