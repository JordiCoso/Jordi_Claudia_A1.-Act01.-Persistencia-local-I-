import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/bienvenida.dart';

class PantallaAjustes extends StatefulWidget {
  //recibimos el preferenciasService.
  final PreferenciasService preferenciasService;
  
  const PantallaAjustes({super.key, required this.preferenciasService,});

  @override
  State<PantallaAjustes> createState() => _PantallaAjustesState(); //creo el estado de la pantalla.
}

class _PantallaAjustesState extends State<PantallaAjustes> {
  bool _temaOscuro = false;
  bool _ocultarCompletado = false;
  double _tamanoLetra = 14;

  //cargamos los ajustes guardados al abrir la pantalla.
  @override
  void initState() {
    super.initState();

    _temaOscuro = widget.preferenciasService.obtenerTemaOscuro();
    _tamanoLetra = widget.preferenciasService.obtenerTamanoLetra();
    _ocultarCompletado = widget.preferenciasService.obtenerOcultarCompletados();
  }

  void _cambiarTemaOscuro(bool nuevoTema) { //cambia el tema.
    setState(() {
      _temaOscuro = nuevoTema;
    });

    widget.preferenciasService.guardarTemaOscuro(nuevoTema); //guardamos el tema.
  }

  void _cambiarTamanoLetra(double nuevoTamano) { //cambia el tamaño de la letra.
    setState(() {
      _tamanoLetra = nuevoTamano;
    });

    widget.preferenciasService.guardarTamanoLetra(nuevoTemano); //guardamos el tamaño.
  }

  void _cambiarOcultarCompletado(bool nuevoHabitoCompletado) { //cambia la opción de ocultar hábitos.
    setState(() {
      _ocultarCompletado = nuevoHabitoCompletado;
    });

    widget.preferenciasService.guardarOcultarCompletados(nuevoHabitoCompletado); //guardamos ocultar hábitos.
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

            //creamos botón para volver y devolver el valor del modo oscuro.
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, _temaOscuro);
              },
              ),
            
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

            SizedBox(height: 24),

            //botón para borrar todos los datos de la aplicación.
            ElevatedButton(
              onPressed: () async {
                //esperamos a que se eliminen los datos guardados.
                await widget.preferenciasService.borrarTodosLosDatos();

                //comprobamos que la pantalla siga abierta.
                if(!mounted) return;

                //volvemos a la pantalla de bienvenida.
                Navigator.pushAndRemoveUntil(
                  context, MaterialPageRoute(
                    builder: (context) => Bienvenida(preferenciasService: widget.preferenciasService,
                      ),
                    ),
                  (route) => false, //de esta forma se borran las rutas de la pantalla cuando se borran los datos.
                  );
              },
              child:Text('Borrar todos los datos'),
              ),
          ],
        ),
      ),
    );
  }
}

