import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';

class PantallaEstadisticas extends StatefulWidget {
  final PreferenciasService _preferenciasService;

  const PantallaEstadisticas({super.key, required this._preferenciasService});

  @override
  State<PantallaEstadisticas> createState() => _PantallaEstadisticas();
}

class _PantallaEstadisticas extends State<PantallaEstadisticas> {
  //creo una variable con el texto que aparece mientras de intenta recuperar la última fecha.
  String ultimaApertura = 'Cargando...';

  //agregamos vairable de número de aperturas.
  int numeroApertura = 0;

  //indicamos el formato de fecha.
  DateFormat formato = DateFormat('dd-MM-yyyy HH:mm:ss');

  //creamos un método que se ejecuta cuando se crea la pantalla.
  @override
  void initState() {
    super.initState();

    cargarUltimaApertura(widget._preferenciasService);
    cargarNumeroAperturas(widget._preferenciasService);
  }

  //creamos un método para poder recuperar la última apertuda de la aplicación.
  void cargarUltimaApertura(PreferenciasService _preferenciasService) {
    //recuperamos la fecha utilizando lo creado anteriormente en Preferencias.
    String? fecha = _preferenciasService.obtenerUltimaApertura();

    //comprobamos que la pantalla sigue abierta con el mounted.
    if (!mounted) {
      return;
    }

    //actualizamos la fecha que aparece en pantalla.
    setState(() {
      ultimaApertura = fecha ?? 'No hay ninguna fecha guardada.'; //si fecha es null, mostrará el mensaje, sino saldrá la última fecha guardada.
    });
  }

  //recuperamos el número de aperturas guardado.
  void cargarNumeroAperturas(PreferenciasService _preferenciasService) {
    //cogemos el contador creado en PreferenciasService.
    int numero = _preferenciasService.obtenerNumeroAperturas();

    //comprobamos que la pantalla sigue abierta con el mounted.
    if (!mounted) {
      return;
    }

    //actualizamos el número que aparece en pantalla.
    setState(() {
      numeroApertura = numero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Estadísticas')),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),

        child: Column(
          children: [
            Text(
              'Estadísticas de los hábitos.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            //TODO: MOSTRAR HÁBITOS.
            Text('Todavía no hay hábitos para mostrar.'),

            SizedBox(height: 24),

            Text(
              'Estadísticas de la aplicación',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            //mostramos la fecha de la última apertura recuperada del SharedPreferences.
            Text('Última apertura de la aplicación: $ultimaApertura'),
          ],
        ),
      ),
    );
  }
}
