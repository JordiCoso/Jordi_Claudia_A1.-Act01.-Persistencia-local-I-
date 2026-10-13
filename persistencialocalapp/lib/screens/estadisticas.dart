import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PantallaEstadisticas extends StatefulWidget {
  const PantallaEstadisticas({super.key});

  @override
  State<PantallaEstadisticas> createState() => _PantallaEstadisticas();

}

  class _PantallaEstadisticas extends State<PantallaEstadisticas> {

  static DateTime ahora = DateTime.now();
  static DateFormat formato = DateFormat('dd-mm-yyyy HH:mm:ss'); //definimos el formato de fecha y hora.

  String fechaParaGuardar = formato.format(ahora);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas'),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),

        child: Column(
          children: [
            Text('Estadísticas de los hábitos.',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            ),

            SizedBox(height: 16),

            Text('Todavía no hay hábitos para mostrar.'),

            SizedBox(height: 24),

            Text('Estadísticas de la aplicación',
            style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),

            Text('Número de aperturas de la aplicación: '), //TODO

            SizedBox(height: 16),

            Text('Última apertura de la aplicación: ' + fechaParaGuardar),
          ],
        ),
      ),
    );
  }
}