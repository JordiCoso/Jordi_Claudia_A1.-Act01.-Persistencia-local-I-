import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/bienvenida.dart';
import 'package:persistencialocalapp/screens/principal.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  PreferenciasService _preferenciasService = await PreferenciasService.crear();

  runApp(MyApp(preferenciasService: _preferenciasService));
}

class MyApp extends StatelessWidget {
  final PreferenciasService _preferenciasService;

  const MyApp({super.key, required this._preferenciasService});

  @override
  Widget build(BuildContext ctxt) {
    return MaterialApp(home: comprobarInicio(this._preferenciasService));
  }
}

Widget comprobarInicio(PreferenciasService _preferenciasService) {
  bool primerInicio = _preferenciasService.getPrimerInicio() ?? true;
  return primerInicio
      ? Bienvenida(preferenciasService: _preferenciasService)
      : Principal(preferenciasService: _preferenciasService);
}
