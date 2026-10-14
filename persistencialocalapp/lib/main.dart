import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/bienvenida.dart';
import 'package:persistencialocalapp/screens/principal.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  PreferenciasService hola = new PreferenciasService();

  runApp(MyApp(preferencias: await hola.GetPreferences()));
}

class MyApp extends StatelessWidget {
  final SharedPreferences _preferencias;

  const MyApp({super.key, required this._preferencias});

  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(home: ComprobarInicio(this._preferencias));
  }
}

Widget ComprobarInicio(SharedPreferences preferencias) {
  bool primerInicio = preferencias.getBool("primerInicio") ?? true;
  return primerInicio
      ? Bienvenida(preferencias: preferencias)
      : Principal(preferencias: preferencias);
}
