import 'package:flutter/material.dart';

class PantallaEstadisticas extends StatelessWidget {
  const PantallaEstadisticas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas'),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),

        child: Column(
          childer: [
            Text('Estadísticas de los hábitos.',
            style: TextStyle(
              fontsize: 24,
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

            Text('Última apertura de la aplicación'), //TODO
          ],
        ),
      ),
    );
  }
}