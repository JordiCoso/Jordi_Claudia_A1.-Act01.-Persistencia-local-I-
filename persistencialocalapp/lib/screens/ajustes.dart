import 'package:flutter/material.dart';

class PantallaAjustes extends StatefulWidget {
  const PantallaAjustes({super.key});

  @override
  State<PantallaAjustes> createState() => _PantallaAjustesState(); //creo el estado de la pantalla.
}

class _PantallaAjustesState extends State<PantallaAjustes> {
  bool _temaOscuro = false;
  bool _ocultarCompletado = false;
  double _tamanoLetra = 14;

  void _cambiarTemaOscuro(bool nuevoTema) { //cambia el tema.
    setState(() {
      _temaOscuro = nuevoTema;
    });
  }

  void _cambiarTamanoLetra(double nuevoTamano) { //cambia el tamaño de la letra.
    setState(() {
      _tamanoLetra = nuevoTamano;
    });
  }

  void _cambiarOcultarCompletado(bool nuevoHabitoCompletado) { //cambia la opción de ocultar hábitos.
    setState(() {
      _ocultarCompletado = nuevoHabitoCompletado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajustes'),
      ),

      body: SingleChildScrollView( //el contenido de la pantalla.
        padding: EdgeInsets.all(24),

        child: Column(
          children: [
            Text('Configuración',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),

            SizedBox(height: 24),


            SwitchListTile( //hacemos el interrumptor para el modo oscuro.
            title: Text('Modo oscuro'),
              value: _temaOscuro,
              onChanged: _cambiarTemaOscuro,
            ),

            SizedBox(height: 24),

            Text('Tamaño de la letra: ${_tamanoLetra.round()}'),
            Slider( //la barra deslizante para el tamaño.
            value: _tamanoLetra,
              min: 10,
              max: 26,
              divisions: 16, //divide el intervalo de la barra en 16.
              onChanged: _cambiarTamanoLetra,
            ),

            SizedBox(height: 24),

            //ponemos un texto de ejemplo para comprobar el tamaño de la letra.
            Text('Así se verá con el tamaño de letra seleccionado.',
              style: TextStyle(fontSize: _tamanoLetra),
            ),

            SizedBox(height: 24),

            SwitchListTile(
              title: Text('Hábito completado por hoy',
              ),
              value: _ocultarCompletado,
              onChanged: _cambiarOcultarCompletado,
            ),
          ],
        ),
      ),
    );
  }
}

