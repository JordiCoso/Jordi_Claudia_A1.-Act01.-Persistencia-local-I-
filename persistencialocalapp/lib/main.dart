import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/ajustes.dart';
import 'package:persistencialocalapp/screens/estadisticas.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';

Future<void> main() async {

  //preparamos flutter para utilizar las preferencias.
  WidgetsFlutterBinding.ensureInitialized();

  //creamos un objeto de nuestro servicio.
  PreferenciasService _preferenciasService = await PreferenciasService.crear();

  //aumentamos el número de aperturas.
  _preferenciasService.aumentarNumeroAperturar();

  //guardamos la fecha de apertura.
  _preferenciasService.registrarApertura();

  runApp(MyApp(preferenciasService: _preferenciasService));
}

class MyApp extends StatelessWidget {
  final PreferenciasService _preferenciasService;
  const MyApp({super.key, required this._preferenciasService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'HabitosApp',
      home: PantallaInicio(preferenciasService: _preferenciasService,),
    );
  }
}

//pantalla principal de prueba.
class PantallaInicio extends StatelessWidget {
  final PreferenciasService _preferenciasService;
  const PantallaInicio({super.key, required this._preferenciasService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HabitosApp'),
      ),

      body: Center(
        child: Column(
          children: [

            //botón para estadísticas.
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaEstadisticas(preferenciasService: _preferenciasService,),
              ),
              );
            },
              child: Text('Estadísticas'),
            ),

            SizedBox(height: 24),

            //botón ajustes.
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaAjustes(),
              ),
              );
            },

              child: Text('Ajustes'),
            ),
          ],
        ),
      ),
    );
  }
}